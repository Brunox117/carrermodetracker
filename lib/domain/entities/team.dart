import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:isar/isar.dart';

part 'team.g.dart';

@collection
class Team {
  Id id = Isar.autoIncrement;
  String name;

  String acronimos;

  String logoURL;

  // Backlink para obtener los jugadores del equipo
  @Backlink(to: 'team')
  final players = IsarLinks<Player>();

  Team({
    required this.name,
    required this.acronimos,
    this.logoURL = '',
  });
}
