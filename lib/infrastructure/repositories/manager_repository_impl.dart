import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/repositories/manager_repository.dart';
import 'package:isar/isar.dart';

class ManagerRepositoryImpl extends ManagerRepository{
  final ManagerRepository managerRepository;

  ManagerRepositoryImpl({required this.managerRepository});

  @override
  Future<bool> deleteManager(Id id) {
    return managerRepository.deleteManager(id);
  }

  @override
  Future<Manager> getManager(Id id) {
    return managerRepository.getManager(id);
  }

  @override
  Future<Manager> saveManager(Manager manager) {
    return managerRepository.saveManager(manager);
  }

  @override
  Future<bool> updateManger(Id id, Manager manager) {
    return managerRepository.updateManger(id, manager);
  }
}