import 'package:carrermodetracker/infrastructure/datasources/isar_manager_datasource.dart';
import 'package:carrermodetracker/infrastructure/repositories/manager_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final managersStorageProvider = Provider((ref) {
  return ManagerRepositoryImpl(datasource: IsarManagerDatasource());
});