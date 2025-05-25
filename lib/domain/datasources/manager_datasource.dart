import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:isar/isar.dart';

abstract class ManagerDatasource {
  Future<Manager> getManager(Id id);

  Future<Manager> saveManager(Manager manager);

  Future<bool> deleteManager(Id id);

  Future<bool> updateManger(Id id, Manager manager);
}
