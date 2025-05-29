import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:isar/isar.dart';

part 'manager_stat.g.dart';

@collection
class Managerstat {
  Id id = Isar.autoIncrement;
  int playedMatches;
  int wins;
  int loses;
  int draws;
  int goalsScored;
  int goalsConceded;

  final manager = IsarLink<Manager>();
  final season = IsarLink<Season>();
  final team = IsarLink<Team>();

  Managerstat({
    required this.playedMatches,
    required this.wins,
    required this.loses,
    required this.draws,
    required this.goalsScored,
    required this.goalsConceded,
  });
}
