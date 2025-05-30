import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/manager_stat_datasource.dart';
import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:isar/isar.dart';

class IsarManagerStatDatasource extends ManagerStatDatasource {
  late Future<Isar> db;
  IsarManagerStatDatasource() {
    db = openDB([
      TeamSchema,
      PlayerSchema,
      StatsSchema,
      SeasonSchema,
      TournamentSchema,
      ManagerSchema,
      ManagerTournamentStatSchema,
      ManagerstatSchema,
    ]);
  }

  @override
  Future<bool> deleteManagerStats(Id id) async {
    final isar = await db;
    final managerStat =
        await isar.managerstats.filter().idEqualTo(id).findFirst();
    if (managerStat != null) {
      isar.writeTxn(() => isar.managerstats.delete(id));
      return true;
    }
    return false;
  }

  @override
  Future<Managerstat> getManagerStat(Id id) async {
    final isar = await db;
    final managerStat =
        await isar.managerstats.filter().idEqualTo(id).findFirst();
    if (managerStat != null) {
      return managerStat;
    }
    throw Exception('Manager stat not found');
  }

  @override
  Future<Managerstat?> getManagerStatByDoubleKey(
      Id managerId, Id seasonId) async {
    final isar = await db;
    final managerStat = await isar.managerstats
        .filter()
        .team((q) => q.idEqualTo(managerId))
        .season((q) => q.idEqualTo(seasonId))
        .findFirst();
    if (managerStat != null) {
      return managerStat;
    }
    return null;
  }

  @override
  Future<List<Managerstat>> getManagerStatsByManager(
      {int limit = 10, offset = 10, required Id id}) async {
    final isar = await db;
    final managerStats = await isar.managerstats
        .filter()
        .manager((q) => q.idEqualTo(id))
        .findAll();
    return managerStats;
  }

  @override
  Future<List<Managerstat>> getManagerStatsBySeason(
      {int limit = 10, offset = 10, required Id id}) async {
    final isar = await db;
    final managerStats = await isar.managerstats
        .filter()
        .season((q) => q.idEqualTo(id))
        .findAll();
    return managerStats;
  }

  @override
  Future<Managerstat> saveManagerStat(Managerstat managerStat) async {
    final isar = await db;
    final newID =
        isar.writeTxnSync<int>(() => isar.managerstats.putSync(managerStat));
    managerStat.id = newID;
    return managerStat;
  }

  @override
  Future<bool> updateManagerStats(Id id, Managerstat managerStat) async {
    final isar = await db;
    final originalManagerStat = await isar.managerstats.get(id);
    if (originalManagerStat == null) return false;
    originalManagerStat.draws = managerStat.draws;
    originalManagerStat.loses = managerStat.loses;
    originalManagerStat.wins = managerStat.wins;
    originalManagerStat.goalsConceded = managerStat.goalsConceded;
    originalManagerStat.goalsScored = managerStat.goalsScored;
    originalManagerStat.playedMatches = managerStat.playedMatches;
    isar.writeTxnSync(() => isar.managerstats.putSync(originalManagerStat));
    return true;
  }

  @override
  Future<List<Managerstat>> loadNextPage({int limit = 10, offset = 10}) async {
    final isar = await db;
    return isar.managerstats.where().offset(offset).limit(limit).findAll();
  }
}
