import 'package:carrermodetracker/infrastructure/datasources/isar_season_datasource.dart';
import 'package:carrermodetracker/infrastructure/repositories/season_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final seasonsStorageProvider = Provider(
  (ref) {
    return SeasonRepositoryImpl(datasource: IsarSeasonDatasource());
  },
);
