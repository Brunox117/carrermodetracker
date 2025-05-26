import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/repositories/manager_stat_repository.dart';
import 'package:isar/isar.dart';

class ManagerStatRepositoryImpl extends ManagerStatRepository {
  final ManagerStatRepository managerStatRepository;

  ManagerStatRepositoryImpl({required this.managerStatRepository});

  @override
  Future<bool> deleteManagerStats(Id id) {
    return managerStatRepository.deleteManagerStats(id);
  }

  @override
  Future<Managerstat> getManagerStat(Id id) {
    return managerStatRepository.getManagerStat(id);
  }

  @override
  Future<Managerstat?> getManagerStatByTripleKey(
      Id managerId, Id tournamentId, Id seasonId) {
    return getManagerStatByTripleKey(managerId, tournamentId, seasonId);
  }

  @override
  Future<List<Managerstat>> getManagerStatsByManager(
      {int limit = 10, offset = 10, required Id id}) {
    return getManagerStatsByManager(id: id);
  }

  @override
  Future<List<Managerstat>> getManagerStatsBySeason(
      {int limit = 10, offset = 10, required Id id}) {
    return getManagerStatsBySeason(id: id);
  }

  @override
  Future<List<Managerstat>> getManagerStatsByTournament(
      {int limit = 10, offset = 10, required Id id}) {
    return getManagerStatsByTournament(id: id);
  }

  @override
  Future<Managerstat> saveManagerStat(Managerstat managerStat) {
    return saveManagerStat(managerStat);
  }

  @override
  Future<bool> updateManagerStats(Id id, Managerstat managerStat) {
    return managerStatRepository.updateManagerStats(id, managerStat);
  }
}
