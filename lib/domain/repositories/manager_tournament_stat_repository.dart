import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:isar/isar.dart';

abstract class ManagerTournamentStatRepository {
  Future<ManagerTournamentStat> saveManagerTournamentStat(
      ManagerTournamentStat managerTournamentStat);

  Future<List<ManagerTournamentStat>> loadNextPage({int limit = 10, offset = 10});

  Future<ManagerTournamentStat> getManagerTournamentStat(Id id);

  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByTournament(
      {int limit = 10, offset = 10, required Id id});

  Future<List<ManagerTournamentStat>> getManagerTournamentStatsBySeason(
      {int limit = 10, offset = 10, required Id id});

  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByManager(
      {int limit = 10, offset = 10, required Id id});

  Future<bool> updateManagerTournamentStats(
      Id id, ManagerTournamentStat managerTournamentStat);

  Future<bool> deleteManagerTournamentStats(Id id);

  Future<ManagerTournamentStat?> getManagerTournamentStatByTripleKey(
      Id managerId, Id tournamentId, Id seasonId);
}
