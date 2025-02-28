import 'package:carrermodetracker/infrastructure/datasources/isar_team_datasource.dart';
import 'package:carrermodetracker/infrastructure/repositories/team_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teamsStorageProvider = Provider(
  (ref) {
    return TeamRepositoryImpl(datasource: IsarTeamDatasource());
  },
);
