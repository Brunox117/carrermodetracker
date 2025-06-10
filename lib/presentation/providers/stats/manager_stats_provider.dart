import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/repositories/manager_stat_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/managers_stats_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final managerStatsProvider =
    StateNotifierProvider<StorageManagerStatsNotifier, Map<int, Managerstat>>(
  (ref) => StorageManagerStatsNotifier(
    managerStatsRepository: ref.read(managerStatsStorageProvider),
  ),
);

class StorageManagerStatsNotifier extends StateNotifier<Map<int, Managerstat>> {
  int page = 0;
  bool isLoadingNextPage = false;
  final ManagerStatRepository managerStatsRepository;

  StorageManagerStatsNotifier({required this.managerStatsRepository})
      : super({});

  Future<void> initialize() async {
    page = 0;
    state = {};
    await loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (isLoadingNextPage) return;
    isLoadingNextPage = true;
    final managerStats =
        await managerStatsRepository.loadNextPage(offset: page * 10, limit: 10);
    page++;
    final tempManagerStatsMap = <int, Managerstat>{};
    for (final managerStat in managerStats) {
      tempManagerStatsMap[managerStat.id] = managerStat;
    }
    state = {...state, ...tempManagerStatsMap};
    isLoadingNextPage = false;
  }

  Future<void> addManagerStat(Managerstat managerStat) async {
    final newManagerStat =
        await managerStatsRepository.saveManagerStat(managerStat);
    state = {...state, newManagerStat.id: newManagerStat};
  }

  Future<void> updateManagerStat(int id, Managerstat managerStat) async {
    await managerStatsRepository.updateManagerStats(id, managerStat);
    managerStat.id = id;
    state = {...state, id: managerStat};
  }

  Future<Managerstat?> getManagerStatByDoubleKey(
      int seasonId, int teamId) async {
    final managerStat = await managerStatsRepository.getManagerStatByDoubleKey(
        teamId, seasonId);
    if (managerStat != null) {
      state = {...state, managerStat.id: managerStat};
    }
    return managerStat;
  }

  Future<void> deleteManagerStat(int id) async {
    await managerStatsRepository.deleteManagerStats(id);
    state = {...state}..remove(id);
  }
}
