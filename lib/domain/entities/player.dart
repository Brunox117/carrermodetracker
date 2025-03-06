import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:isar/isar.dart';

part 'player.g.dart';

@collection
class Player {
  Id id = Isar.autoIncrement;
  String name;
  final int teamId;

  // Link para acceder al equipo relacionado
  final team = IsarLink<Team>();

  Player({
    required this.name,
    required this.teamId,
  });
}