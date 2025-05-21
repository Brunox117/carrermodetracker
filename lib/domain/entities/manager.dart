import 'package:isar/isar.dart';

import 'package:carrermodetracker/domain/entities/manager_stat.dart';

part 'manager.g.dart';

@collection
class Manager {
  Id id = Isar.autoIncrement;
  String name;
  String imageUrl;
  @Backlink(to: 'manager')
  final managerStats = IsarLink<Managerstat>();

  Manager({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}
