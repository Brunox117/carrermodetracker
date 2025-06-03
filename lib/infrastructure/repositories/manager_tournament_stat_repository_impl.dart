import 'package:carrermodetracker/domain/datasources/manager_tournament_stat_datasource.dart';
import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/repositories/manager_tournament_stat_repository.dart';
import 'package:isar/isar.dart';

class ManagerTournamentStatRepositoryImpl
    extends ManagerTournamentStatRepository {
  final ManagerTournamentStatDatasource datasource;

  ManagerTournamentStatRepositoryImpl(
      {required this.datasource});

  @override
  Future<bool> deleteManagerTournamentStats(Id id) {
    return datasource.deleteManagerTournamentStats(id);
  }

  @override
  Future<ManagerTournamentStat> getManagerTournamentStat(Id id) {
    return datasource.getManagerTournamentStat(id);
  }

  @override
  Future<ManagerTournamentStat?> getManagerTournamentStatByTripleKey(
      Id managerId, Id tournamentId, Id seasonId) {
    return datasource.getManagerTournamentStatByTripleKey(
        managerId, tournamentId, seasonId);
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByManager(
      {int limit = 10, offset = 10, required Id id}) {
    return datasource.getManagerTournamentStatsByManager(
        id: id, limit: limit, offset: offset);
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsBySeason(
      {int limit = 10, offset = 10, required Id id}) {
    return datasource.getManagerTournamentStatsByManager(
        limit: limit, offset: offset, id: id);
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByTournament(
      {int limit = 10, offset = 10, required Id id}) {
    return datasource
        .getManagerTournamentStatsByTournament(
            id: id, limit: limit, offset: offset);
  }

  @override
  Future<ManagerTournamentStat> saveManagerTournamentStat(
      ManagerTournamentStat managerTournamentStat) {
    return datasource
        .saveManagerTournamentStat(managerTournamentStat);
  }

  @override
  Future<bool> updateManagerTournamentStats(Id id, ManagerTournamentStat managerTournamentStat) {
    return datasource.updateManagerTournamentStats(id, managerTournamentStat);
  }
  
  @override
  Future<List<ManagerTournamentStat>> loadNextPage({int limit = 10, offset = 10}) {
    return datasource.loadNextPage(limit: limit, offset: offset);
  }
  
  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByDoubleKey(Id teamId, Id seasonId) {
    return datasource.getManagerTournamentStatsByDoubleKey(teamId, seasonId);
  }
}
