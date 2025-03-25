import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/stats_datasource.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:isar/isar.dart';

class IsarStatsDatasource extends StatsDatasource {
  late Future<Isar> db;
  IsarStatsDatasource() {
    db = openDB(StatsSchema);
  }

  @override
  Future<bool> deleteStats(Id id) {
    // TODO: implement deleteStats
    throw UnimplementedError();
  }

  @override
  Future<List<Stats>> getALlStats({int limit = 10, offset = 0}) {
    // TODO: implement getALlStats
    throw UnimplementedError();
  }

  @override
  Future<Stats> getStats(Id id) {
    // TODO: implement getStats
    throw UnimplementedError();
  }

  @override
  Future<bool> saveStats(Stats stats) {
    // TODO: implement saveStats
    throw UnimplementedError();
  }

  @override
  Future<bool> updateStats(Id id, Stats stats) {
    // TODO: implement updateStats
    throw UnimplementedError();
  }
}
