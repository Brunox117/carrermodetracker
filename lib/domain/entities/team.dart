import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:isar/isar.dart';

part 'team.g.dart';

@collection
class Team {
  Id id = Isar.autoIncrement;
  String name;

  String acronimos;

  String logoURL;

  // Backlink para obtener los jugadores del equipo
  @Backlink(to: 'teams')
  final players = IsarLinks<Player>();
  @Backlink(to: 'team')
  final managerStat = IsarLinks<Managerstat>();
  @Backlink(to: 'team')
  final stat = IsarLinks<Stats>();
  @Backlink(to: 'team')
  final managerTournamentStats = IsarLinks<ManagerTournamentStat>();

  Team({
    required this.name,
    required this.acronimos,
    this.logoURL = '',
  });
}
