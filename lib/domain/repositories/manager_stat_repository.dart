import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:isar/isar.dart';

abstract class ManagerStatRepository {
  Future<Managerstat> saveManagerStat(Managerstat managerStat);

  Future<Managerstat> getManagerStat(Id id);

  Future<List<Managerstat>> loadNextPage({int limit = 10, offset = 10});


  Future<List<Managerstat>> getManagerStatsBySeason(
      {int limit = 10, offset = 10, required Id id});

  Future<List<Managerstat>> getManagerStatsByManager(
      {int limit = 10, offset = 10, required Id id});

  Future<bool> updateManagerStats(Id id, Managerstat managerStat);

  Future<bool> deleteManagerStats(Id id);

  Future<Managerstat?> getManagerStatByDoubleKey(Id teamId, Id seasonId);
}
