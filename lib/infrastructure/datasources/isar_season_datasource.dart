import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/season_datasource.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:isar/isar.dart';

class IsarSeasonDatasource extends SeasonDatasource {
  late Future<Isar> db;
  IsarSeasonDatasource() {
    db = openDB(SeasonSchema);
  }

  @override
  Future<bool> deleteSeason(Id id) {
    // TODO: implement deleteSeason
    throw UnimplementedError();
  }

  @override
  Future<Season> getSeason(Id id) {
    // TODO: implement getSeason
    throw UnimplementedError();
  }

  @override
  Future<List<Season>> getSeasons({int limit = 10, offset = 0}) {
    // TODO: implement getSeasons
    throw UnimplementedError();
  }

  @override
  Future<bool> saveSeason(Season season) {
    // TODO: implement saveSeason
    throw UnimplementedError();
  }

  @override
  Future<bool> updateSeason(Id id, Season season) {
    // TODO: implement updateSeason
    throw UnimplementedError();
  }
}
