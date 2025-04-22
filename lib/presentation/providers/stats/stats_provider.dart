import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/repositories/stats_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/stats_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final statsProvider =
    StateNotifierProvider<StorageStatsNotifier, Map<int, Stats>>(
  (ref) {
    final statsStorageRepository = ref.watch(statsStorageProvider);
    return StorageStatsNotifier(statsStorageRepository: statsStorageRepository);
  },
);

class StorageStatsNotifier extends StateNotifier<Map<int, Stats>> {
  int page = 0;
  final StatsRepository statsStorageRepository;

  StorageStatsNotifier({required this.statsStorageRepository}) : super({});

  Future<void> saveStats(Stats stats) async {
    final statsWId = await statsStorageRepository.saveStats(stats);
    state = {...state, statsWId.id: statsWId};
  }

  Future<Stats> getStats(int id) async {
    if (state.containsKey(id)) {
      return state[id]!;
    }

    Stats stats = await statsStorageRepository.getStats(id);
    state = {...state, stats.id: stats};
    return stats;
  }

  Future<List<Stats>> getStatsByTournament({required int id}) async {
    List<Stats> listStats =
        await statsStorageRepository.getStatsByTournament(id: id);
    final newStats = {for (var stat in listStats) stat.id: stat};
    state = {...state, ...newStats};

    return listStats;
  }

  Future<List<Stats>> getStatsBySeason({required int id}) async {
    List<Stats> listStats =
        await statsStorageRepository.getStatsBySeason(id: id);
    final newStats = {for (var stat in listStats) stat.id: stat};
    state = {...state, ...newStats};

    return listStats;
  }

  Future<List<Stats>> getStatsByPlayer({required int id}) async {
    List<Stats> listStats =
        await statsStorageRepository.getStatsByPlayer(id: id);
    final newStats = {for (var stat in listStats) stat.id: stat};
    state = {...state, ...newStats};

    return listStats;
  }

  Future<void> deleteStats(int id) async {
    await statsStorageRepository.deleteStats(id);
    state = {...state}..remove(id);
  }

  Future<void> updateStats(int id, Stats stats) async {
    await statsStorageRepository.updateStats(id, stats);
    state = {...state, stats.id: stats};
  }

  Future<Stats?> getStatByTripleKey(
      int playerId, int tournamentId, int seasonId) async {

    return await statsStorageRepository.getStatByTripleKey(
        playerId, tournamentId, seasonId);
  }
}
