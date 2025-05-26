import 'package:carrermodetracker/infrastructure/datasources/isar_manager_tournament_stat_datasource.dart';
import 'package:carrermodetracker/infrastructure/repositories/manager_tournament_stat_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final managersTournamentStatsStorageProvider = Provider(
  (ref) {
    return ManagerTournamentStatRepositoryImpl(datasource: IsarManagerTournamentStatDatasource());
  },
);