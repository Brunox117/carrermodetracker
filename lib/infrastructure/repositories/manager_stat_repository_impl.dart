import 'package:carrermodetracker/domain/datasources/manager_stat_datasource.dart';
import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/repositories/manager_stat_repository.dart';
import 'package:isar/isar.dart';

class ManagerStatRepositoryImpl extends ManagerStatRepository {
  final ManagerStatDatasource datasource;

  ManagerStatRepositoryImpl({required this.datasource});

  @override
  Future<bool> deleteManagerStats(Id id) {
    return datasource.deleteManagerStats(id);
  }

  @override
  Future<Managerstat> getManagerStat(Id id) {
    return datasource.getManagerStat(id);
  }

  @override
  Future<List<Managerstat>> getManagerStatsByManager(
      {int limit = 10, offset = 10, required Id id}) {
    return datasource.getManagerStatsByManager(id: id);
  }

  @override
  Future<List<Managerstat>> getManagerStatsBySeason(
      {int limit = 10, offset = 10, required Id id}) {
    return datasource.getManagerStatsBySeason(id: id);
  }

  @override
  Future<Managerstat> saveManagerStat(Managerstat managerStat) {
    return datasource.saveManagerStat(managerStat);
  }

  @override
  Future<bool> updateManagerStats(Id id, Managerstat managerStat) {
    return datasource.updateManagerStats(id, managerStat);
  }

  @override
  Future<List<Managerstat>> loadNextPage({int limit = 10, offset = 10}) {
    return datasource.loadNextPage(limit: limit, offset: offset);
  }

  @override
  Future<Managerstat?> getManagerStatByDoubleKey(Id managerId, Id seasonId) {
    return datasource.getManagerStatByDoubleKey(managerId, seasonId);
  }
}
