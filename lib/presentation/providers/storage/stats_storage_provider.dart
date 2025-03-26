import 'package:carrermodetracker/infrastructure/datasources/isar_stats_datasource.dart';
import 'package:carrermodetracker/infrastructure/repositories/stats_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final statsStorageProvider = Provider(
  (ref) {
    return StatsRepositoryImpl(datasource: IsarStatsDatasource());
  },
);
