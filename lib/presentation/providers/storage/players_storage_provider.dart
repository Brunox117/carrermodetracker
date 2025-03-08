import 'package:carrermodetracker/infrastructure/datasources/isar_player_datasource.dart';
import 'package:carrermodetracker/infrastructure/repositories/player_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playersStorageProvider = Provider(
  (ref) {
    return PlayerRepositoryImpl(datasource: IsarPlayerDatasource());
  },
);
