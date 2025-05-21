import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:isar/isar.dart';

part 'manager_stat.g.dart';

@collection
class Managerstat {
  Id id = Isar.autoIncrement;
  int goals;
  int playedMatches;
  int wins;
  int loses;
  int draws;
  int goalsScored;
  int goalsConceded;

  final manager = IsarLink<Manager>();

  Managerstat({
    required this.goals,
    required this.playedMatches,
    required this.wins,
    required this.loses,
    required this.draws,
    required this.goalsScored,
    required this.goalsConceded,
  });
}
