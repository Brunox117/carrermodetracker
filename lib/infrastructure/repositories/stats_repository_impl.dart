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
  Future<List<Stats>> getALlStats({int limit = 10, offset = 0}) {
    return datasource.getALlStats(limit: limit, offset: offset);
  }

  @override
  Future<Stats> getStats(Id id) {
    return datasource.getStats(id);
  }

  @override
  Future<bool> saveStats(Stats stats) {
    return datasource.saveStats(stats);
  }

  @override
  Future<bool> updateStats(Id id, Stats stats) {
    return datasource.updateStats(id, stats);
  }
}
