import 'package:carrermodetracker/domain/repositories/manager_tournament_stat_repository.dart';
import 'package:carrermodetracker/infrastructure/datasources/isar_manager_tournament_stat_datasource.dart';
import 'package:carrermodetracker/infrastructure/repositories/manager_tournament_stat_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final managerTournamentStatsStorageProvider =
    Provider<ManagerTournamentStatRepository>((ref) {
  return ManagerTournamentStatRepositoryImpl(
      datasource: IsarManagerTournamentStatDatasource());
});
