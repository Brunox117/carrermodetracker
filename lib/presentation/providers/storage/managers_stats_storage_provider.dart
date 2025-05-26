import 'package:carrermodetracker/infrastructure/datasources/isar_manager_stat_datasource.dart';
import 'package:carrermodetracker/infrastructure/repositories/manager_stat_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final managerStatsStorageProvider = Provider((ref) {
  return ManagerStatRepositoryImpl(datasource: IsarManagerStatDatasource());
});