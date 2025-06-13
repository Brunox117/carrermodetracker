import 'package:carrermodetracker/domain/datasources/stats_datasource.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/repositories/stats_repository.dart';
import 'package:isar/isar.dart';

class StatsRepositoryImpl extends StatsRepository {
  final StatsDatasource datasource;

  StatsRepositoryImpl({required this.datasource});
  @override
  Future<bool> deleteStats(Id id) {
    return datasource.deleteStats(id);
  }

  @override
  Future<Stats> getStats(Id id) {
    return datasource.getStats(id);
  }

  @override
  Future<Stats> saveStats(Stats stats) {
    return datasource.saveStats(stats);
  }

  @override
  Future<bool> updateStats(Id id, Stats stats) {
    return datasource.updateStats(id, stats);
  }

  @override
  Future<List<Stats>> getStatsByPlayer(
      {int limit = 10, offset = 0, required Id id}) {
    return datasource.getStatsByPlayer(limit: limit, offset: offset, id: id);
  }

  @override
  Future<List<Stats>> getStatsBySeason(
      {int limit = 10, offset = 0, required Id id}) {
    return datasource.getStatsBySeason(id: id, limit: limit, offset: offset);
  }

  @override
  Future<List<Stats>> getStatsByTournament(
      {int limit = 10, offset = 0, required Id id}) {
    return datasource.getStatsByTournament(
        id: id, limit: limit, offset: offset);
  }

  @override
  Future<Stats?> getStatByTripleKey(Id playerId, Id tournamentId, Id seasonId) {
    return datasource.getStatByTripleKey(playerId, tournamentId, seasonId);
  }

  @override
  Future<Stats?> getStatByQuadrupleKey(
      Id playerId, Id tournamentId, Id seasonId, Id teamId) {
    return datasource.getStatByQuadrupleKey(
        playerId, tournamentId, seasonId, teamId);
  }
}
