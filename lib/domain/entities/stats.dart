import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:isar/isar.dart';

part 'stats.g.dart';

@collection
class Stats {
  Id id = Isar.autoIncrement;
  int goals;
  int assists;
  int playedMatches;

  final season = IsarLink<Season>();
  final tournament = IsarLink<Tournament>();
  final player = IsarLink<Player>();

  Stats({
    required this.assists,
    required this.goals,
    required this.playedMatches,
  });
}
