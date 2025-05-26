import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/repositories/manager_tournament_stat_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/managers_tournament_stats_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final managerTournamentStatsProvider = StateNotifierProvider<
    StorageManagerTournamentStatsNotifier, Map<int, ManagerTournamentStat>>(
  (ref) => StorageManagerTournamentStatsNotifier(
    managerTournamentStatsRepository:
        ref.read(managerTournamentStatsStorageProvider),
  ),
);

class StorageManagerTournamentStatsNotifier
    extends StateNotifier<Map<int, ManagerTournamentStat>> {
  int page = 0;
  bool isLoadingNextPage = false;
  final ManagerTournamentStatRepository managerTournamentStatsRepository;

  StorageManagerTournamentStatsNotifier(
      {required this.managerTournamentStatsRepository})
      : super({});

  Future<void> initialize() async {
    page = 0;
    state = {};
    await loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (isLoadingNextPage) return;
    isLoadingNextPage = true;
    final tournamentStats = await managerTournamentStatsRepository.loadNextPage(
        offset: page * 10, limit: 10);
    page++;
    final tempTournamentStatsMap = <int, ManagerTournamentStat>{};
    for (final tournamentStat in tournamentStats) {
      tempTournamentStatsMap[tournamentStat.id] = tournamentStat;
    }
    state = {...state, ...tempTournamentStatsMap};
    isLoadingNextPage = false;
  }

  Future<void> addManagerTournamentStat(
      ManagerTournamentStat tournamentStat) async {
    final newTournamentStat = await managerTournamentStatsRepository
        .saveManagerTournamentStat(tournamentStat);
    state = {...state, newTournamentStat.id: newTournamentStat};
  }

  Future<void> updateManagerTournamentStat(
      int id, ManagerTournamentStat tournamentStat) async {
    final updatedTournamentStat = await managerTournamentStatsRepository
        .updateManagerTournamentStats(id, tournamentStat);
    if (updatedTournamentStat) {
      tournamentStat.id = id;
      state = {...state, id: tournamentStat};
    }
  }

  Future<void> deleteManagerTournamentStat(int id) async {
    final deletedTournamentStat =
        await managerTournamentStatsRepository.deleteManagerTournamentStats(id);
    if (deletedTournamentStat) {
      state.remove(id);
    }
  }
}
