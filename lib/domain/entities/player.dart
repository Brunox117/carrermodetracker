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

  // Link para acceder al equipo relacionado
  final team = IsarLink<Team>();

  Player({
    required this.name,
    required this.number,
    required this.position,
    this.imageURL = '',
  });
}