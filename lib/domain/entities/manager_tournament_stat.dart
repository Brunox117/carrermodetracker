import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:isar/isar.dart';

import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';

part 'manager_tournament_stat.g.dart';

@collection
class ManagerTournamentStat {
  Id id = Isar.autoIncrement;

  String finalPosition;
  bool isWinner;

  final manager = IsarLink<Manager>();
  final season = IsarLink<Season>();
  final tournament = IsarLink<Tournament>();
  final team = IsarLink<Team>();

  ManagerTournamentStat({
    required this.finalPosition,
    required this.isWinner,
  });
}
