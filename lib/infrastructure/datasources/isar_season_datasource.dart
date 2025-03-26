import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/season_datasource.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:isar/isar.dart';

class IsarSeasonDatasource extends SeasonDatasource {
  late Future<Isar> db;
  IsarSeasonDatasource() {
    db = openDB([SeasonSchema]);
  }

  @override
  Future<bool> deleteSeason(Id id) async {
    final isar = await db;
    final season = await isar.seasons.filter().idEqualTo(id).findFirst();
    if (season != null) {
      isar.writeTxnSync(() => isar.seasons.deleteSync(id));
      return true;
    }
    return false;
  }

  @override
  Future<Season> getSeason(Id id) async {
    final isar = await db;
    final season = await isar.seasons.get(id);
    if (season != null) {
      return season;
    }
    throw 'La temporada no existe';
  }

  @override
  Future<List<Season>> getSeasons({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.seasons.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<bool> saveSeason(Season season) async {
    final isar = await db;
    isar.writeTxn(() async {
      await isar.seasons.put(season);
      await season.stats.save();
    });
    return true;
  }

  @override
  Future<bool> updateSeason(Id id, Season season) async {
    final isar = await db;
    final originalSeason = await isar.seasons.get(id);
    if (originalSeason == null) return false;
    originalSeason.season = season.season;
    return true;
  }
}
