import 'dart:convert';

import 'package:isar/isar.dart';

import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';

part 'stats.g.dart';

@collection
class Stats {
  Id id = Isar.autoIncrement;
  int goals;
  int assists;
  int playedMatches;
  int cleanSheets;
  int yellowCards;
  int redCards;
  double avgScore;

  final season = IsarLink<Season>();
  final tournament = IsarLink<Tournament>();
  final player = IsarLink<Player>();

  Stats({
    required this.goals,
    required this.assists,
    required this.playedMatches,
    required this.cleanSheets,
    required this.yellowCards,
    required this.redCards,
    required this.avgScore,
  });
}
