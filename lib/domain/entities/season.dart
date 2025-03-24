import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:isar/isar.dart';

part 'season.g.dart';

@collection
class Season {
  Id id = Isar.autoIncrement;
  String season;

  @Backlink(to: 'season')
  final stats = IsarLinks<Stats>();

  Season({
    required this.season,
  });
}
