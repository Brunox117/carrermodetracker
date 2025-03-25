import 'package:carrermodetracker/domain/datasources/season_datasource.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/repositories/season_repository.dart';
import 'package:isar/isar.dart';

class SeasonRepositoryImpl extends SeasonRepository {
  final SeasonDatasource datasource;

  SeasonRepositoryImpl({required this.datasource});

  @override
  Future<bool> deleteSeason(Id id) {
    return datasource.deleteSeason(id);
  }

  @override
  Future<Season> getSeason(Id id) {
    return datasource.getSeason(id);
  }

  @override
  Future<List<Season>> getSeasons({int limit = 10, offset = 0}) {
    return datasource.getSeasons(limit: limit, offset: offset);
  }

  @override
  Future<bool> saveSeason(Season season) {
    return saveSeason(season);
  }

  @override
  Future<bool> updateSeason(Id id, Season season) {
    return updateSeason(id, season);
  }
}
