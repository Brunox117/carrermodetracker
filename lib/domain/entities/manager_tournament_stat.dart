import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:isar/isar.dart';

part 'manager_tournament_stat.g.dart';

@collection
class ManagerTournamentStat {
  Id id = Isar.autoIncrement;
  
  String finalPosition;
  
  final manager = IsarLink<Manager>();
  final season = IsarLink<Season>();
  final tournament = IsarLink<Tournament>();

  ManagerTournamentStat({
    required this.finalPosition,
  });
} 