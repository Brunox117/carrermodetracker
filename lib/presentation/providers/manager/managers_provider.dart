import 'package:carrermodetracker/config/helpers/image_utilities.dart';
import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/repositories/manager_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/managers_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final managersProvider =
    StateNotifierProvider<StorageManagersNotifier, Manager?>(
  (ref) {
    final managerStorageRepository = ref.watch(managersStorageProvider);
    return StorageManagersNotifier(
        managerStorageRepository: managerStorageRepository);
  },
);

class StorageManagersNotifier extends StateNotifier<Manager?> {
  final ManagerRepository managerStorageRepository;

  StorageManagersNotifier({required this.managerStorageRepository})
      : super(null);

  Future<void> initialize() async {
    state = null;
    await getManager();
  }

  Future<Manager?> getManager() async {
    final manager = await managerStorageRepository.getManager();
    state = manager;
    return manager;
  }

  Future<void> addManager(Manager manager, XFile? imageFile) async {
    final newManager = await managerStorageRepository.saveManager(manager);
    if (imageFile != null) {
      newManager.imageUrl = await saveImageInLocalStorage(
          imageFile, 'managers', manager.id.toString());
      await managerStorageRepository.updateManger(manager.id, manager);
    }
    state = newManager;
  }

  Future<void> updateManager(int id, Manager manager, XFile? imageFile) async {
    Manager? oldManager = state;
    if (imageFile != null && oldManager != null) {
      if (oldManager.imageUrl.isNotEmpty) {
        await deleteImage(oldManager.imageUrl);
      }
      manager.imageUrl =
          await saveImageInLocalStorage(imageFile, 'managers', id.toString());
    }
    manager.id = id;
    await managerStorageRepository.updateManger(id, manager);
    state = manager;
  }

  Future<void> deleteManager(int id) async {
    Future.delayed(
      const Duration(milliseconds: 350),
      () async {
        Manager? manager = state;
        if (manager != null && manager.imageUrl.isNotEmpty) {
          await deleteImage(manager.imageUrl);
        }
        await managerStorageRepository.deleteManager(id);
        state = null;
      },
    );
  }
}
