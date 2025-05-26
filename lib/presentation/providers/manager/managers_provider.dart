import 'package:carrermodetracker/config/helpers/image_utilities.dart';
import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/repositories/manager_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/managers_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final managersProvider =
    StateNotifierProvider<StorageManagersNotifier, Map<int, Manager>>(
  (ref) {
    final managerStorageRepository = ref.watch(managersStorageProvider);
    return StorageManagersNotifier(managerStorageRepository: managerStorageRepository);
  },
);
class StorageManagersNotifier extends StateNotifier<Map<int, Manager>> {
  int page = 0;
  final ManagerRepository managerStorageRepository;

  StorageManagersNotifier({required this.managerStorageRepository}) : super({});

  Future<void> initialize() async {
    page = 0;
    state = {};
    await loadNextPage();
  }

  Future<Manager?> loadNextPage() async {
    final managers = await managerStorageRepository.getManager(1);
    page++;
    final tempManagersMap = <int, Manager>{};
    tempManagersMap[managers.id] = managers;
    state = {...state, ...tempManagersMap};
    return managers;
  }

  Future<void> addManager(Manager manager) async {
    final newManager = await managerStorageRepository.saveManager(manager);
    state = {...state, newManager.id: newManager};
  }

  Future<void> updateManager(int id, Manager manager, XFile? imageFile) async {
    Manager oldManager = await managerStorageRepository.getManager(id);
    if (imageFile != null) {
      if (oldManager.imageUrl.isNotEmpty) {
        await deleteImage(oldManager.imageUrl);
      }
      manager.imageUrl =
          await saveImageInLocalStorage(imageFile, 'managers', id.toString());
    }
    manager.id = id;
    await managerStorageRepository.updateManger(id, manager);
    state = {...state, id: manager};
  }

  Future<void> deleteManager(int id) async {
    Future.delayed(
      const Duration(milliseconds: 350),
      () async {
        Manager? manager = state[id];
        if (manager != null && manager.imageUrl != "") {
          await deleteImage(manager.imageUrl);
        }
        await managerStorageRepository.deleteManager(id);
        state = {...state}..remove(id);
      },
    );
  }
}
