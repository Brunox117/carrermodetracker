import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:isar/isar.dart';

part 'player.g.dart';

@collection
class Player {
  Id id = Isar.autoIncrement;
  String name;
  String number;
  String position;
  String imageURL;

  final teams = IsarLinks<Team>();
  @Backlink(to: 'player')
  final stats = IsarLinks<Stats>();

  Player({
    required this.name,
    required this.number,
    required this.position,
    this.imageURL = '',
  });
}