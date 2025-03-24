import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:isar/isar.dart';

part 'tournament.g.dart';

@collection
class Tournament {
  Id id = Isar.autoIncrement;
  String name;
  String logoURL;

  @Backlink(to: 'tournament')
  final stats = IsarLinks<Stats>();

  Tournament({
    required this.name,
    this.logoURL = '',
  });
}
