import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/repositories/manager_tournament_stat_repository.dart';
import 'package:isar/isar.dart';

class ManagerTournamentStatRepositoryImpl
    extends ManagerTournamentStatRepository {
  final ManagerTournamentStatRepository managerTournamentStatRepository;

  ManagerTournamentStatRepositoryImpl(
      {required this.managerTournamentStatRepository});

  @override
  Future<bool> deleteManagerTournamentStats(Id id) {
    return managerTournamentStatRepository.deleteManagerTournamentStats(id);
  }

  @override
  Future<ManagerTournamentStat> getManagerTournamentStat(Id id) {
    return managerTournamentStatRepository.getManagerTournamentStat(id);
  }

  @override
  Future<ManagerTournamentStat?> getManagerTournamentStatByTripleKey(
      Id managerId, Id tournamentId, Id seasonId) {
    return managerTournamentStatRepository.getManagerTournamentStatByTripleKey(
        managerId, tournamentId, seasonId);
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByManager(
      {int limit = 10, offset = 10, required Id id}) {
    return managerTournamentStatRepository.getManagerTournamentStatsByManager(
        id: id, limit: limit, offset: offset);
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsBySeason(
      {int limit = 10, offset = 10, required Id id}) {
    return managerTournamentStatRepository.getManagerTournamentStatsByManager(
        limit: limit, offset: offset, id: id);
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByTournament(
      {int limit = 10, offset = 10, required Id id}) {
    return managerTournamentStatRepository
        .getManagerTournamentStatsByTournament(
            id: id, limit: limit, offset: offset);
  }

  @override
  Future<ManagerTournamentStat> saveManagerTournamentStat(
      ManagerTournamentStat managerTournamentStat) {
    return managerTournamentStatRepository
        .saveManagerTournamentStat(managerTournamentStat);
  }

  @override
  Future<bool> updateManagerTournamentStats(Id id, ManagerTournamentStat managerTournamentStat) {
    return managerTournamentStatRepository.updateManagerTournamentStats(id, managerTournamentStat);
  }
}
