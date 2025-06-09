import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:isar/isar.dart';

part 'season.g.dart';

@collection
class Season {
  Id id = Isar.autoIncrement;
  String season;

  @Backlink(to: 'season')
  final stats = IsarLinks<Stats>();
  @Backlink(to: 'season')
  final managerStats = IsarLinks<Managerstat>();
  @Backlink(to: 'season')
  final managerTournamentStats = IsarLinks<ManagerTournamentStat>();

  Season({
    required this.season,
  });
}