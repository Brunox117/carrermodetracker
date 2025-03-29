import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:isar/isar.dart';

abstract class SeasonDatasource {
  Future<Season> saveSeason(Season season);

  Future<Season> getSeason(Id id);

  Future<List<Season>> getSeasons({int limit = 10, offset = 0});

  Future<bool> deleteSeason(Id id);

  Future<bool> updateSeason(Id id, Season season);
}
