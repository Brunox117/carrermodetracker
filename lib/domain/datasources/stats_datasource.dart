import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:isar/isar.dart';

abstract class StatsDatasource {
  Future<bool> saveStats(Stats stats);

  Future<Stats> getStats(Id id);

  Future<List<Stats>> getStatsByTournament({int limit = 10, offset = 0, required Id id});

  Future<List<Stats>> getStatsBySeason({int limit = 10, offset = 0, required Id id});

  Future<List<Stats>> getStatsByPlayer({int limit = 10, offset = 0, required Id id});

  Future<bool> deleteStats(Id id);

  Future<bool> updateStats(Id id, Stats stats);
}
