import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/manager_datasource.dart';
import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';

import 'package:isar/isar.dart';

class IsarManagerDatasource extends ManagerDatasource {
  late Future<Isar> db;
  IsarManagerDatasource() {
    db = openDB([
      ManagerSchema,
      ManagerstatSchema,
      ManagerTournamentStatSchema,
    ]);
  }
  @override
  Future<bool> deleteManager(Id id) async {
    final isar = await db;
    final manager = await isar.managers.filter().idEqualTo(id).findFirst();
    if (manager != null) {
      isar.writeTxn(() => isar.managers.delete(id));
      return true;
    }
    return false;
  }

  @override
  Future<Manager> getManager(Id id) async {
    final isar = await db;
    final managers = await isar.managers.where().findAll();
    //Hacemos esto porque de inicio solo se va a crear un manager
    if (managers.isNotEmpty) {
      return managers.first;
    }
    throw Exception('Manager not found');
  }

  @override
  Future<Manager> saveManager(Manager manager) async {
    final isar = await db;
    final newID = isar.writeTxnSync<int>(() => isar.managers.putSync(manager));
    manager.id = newID;
    return manager;
  }

  @override
  Future<bool> updateManger(Id id, Manager manager) async {
    final isar = await db;
    final originalManager = await isar.managers.get(id);
    if (originalManager == null) return false;
    originalManager.name = manager.name;
    originalManager.imageUrl = manager.imageUrl;
    isar.writeTxnSync(() => isar.managers.putSync(originalManager));
    return true;
  }
}
