import 'package:carrermodetracker/domain/datasources/manager_datasource.dart';
import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/repositories/manager_repository.dart';
import 'package:isar/isar.dart';

class ManagerRepositoryImpl extends ManagerRepository{
  final ManagerDatasource datasource;

  ManagerRepositoryImpl({required this.datasource});

  @override
  Future<bool> deleteManager(Id id) {
    return datasource.deleteManager(id);
  }

  @override
  Future<Manager> getManager(Id id) {
    return datasource.getManager(id);
  }

  @override
  Future<Manager> saveManager(Manager manager) {
    return datasource.saveManager(manager);
  }

  @override
  Future<bool> updateManger(Id id, Manager manager) {
    return datasource.updateManger(id, manager);
  }
}