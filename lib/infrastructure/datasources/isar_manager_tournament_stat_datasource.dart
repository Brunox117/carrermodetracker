import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/manager_tournament_stat_datasource.dart';
import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:isar/isar.dart';

class IsarManagerTournamentStatDatasource
    extends ManagerTournamentStatDatasource {
  late Future<Isar> db;
  IsarManagerTournamentStatDatasource() {
    db = openDB([
      PlayerSchema,
      StatsSchema,
      SeasonSchema,
      TournamentSchema,
      ManagerSchema,
      ManagerTournamentStatSchema,
      ManagerstatSchema,
      TeamSchema,
    ]);
  }

  @override
  Future<bool> deleteManagerTournamentStats(Id id) async {
    final isar = await db;
    final managerTournamentStat =
        await isar.managerTournamentStats.filter().idEqualTo(id).findFirst();
    if (managerTournamentStat != null) {
      isar.writeTxn(() => isar.managerTournamentStats.delete(id));
      return true;
    }
    return false;
  }

  @override
  Future<ManagerTournamentStat> getManagerTournamentStat(Id id) async {
    final isar = await db;
    final managerTournamentStat =
        await isar.managerTournamentStats.filter().idEqualTo(id).findFirst();
    if (managerTournamentStat != null) {
      return managerTournamentStat;
    }
    throw Exception('Manager tournament stat not found');
  }

  @override
  Future<ManagerTournamentStat?> getManagerTournamentStatByTripleKey(
      Id managerId, Id tournamentId, Id seasonId) async {
    final isar = await db;
    final managerTournamentStat = await isar.managerTournamentStats
        .filter()
        .manager((q) => q.idEqualTo(managerId))
        .tournament((q) => q.idEqualTo(tournamentId))
        .season((q) => q.idEqualTo(seasonId))
        .findFirst();
    if (managerTournamentStat != null) {
      return managerTournamentStat;
    }
    return null;
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByManager(
      {int limit = 10, offset = 10, required Id id}) async {
    final isar = await db;
    final managerTournamentStats = await isar.managerTournamentStats
        .filter()
        .manager((q) => q.idEqualTo(id))
        .findAll();
    return managerTournamentStats;
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsBySeason(
      {int limit = 10, offset = 10, required Id id}) async {
    final isar = await db;
    final managerTournamentStats = await isar.managerTournamentStats
        .filter()
        .season((q) => q.idEqualTo(id))
        .findAll();
    return managerTournamentStats;
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByTournament(
      {int limit = 10, offset = 10, required Id id}) async {
    final isar = await db;
    final managerTournamentStats = await isar.managerTournamentStats
        .filter()
        .tournament((q) => q.idEqualTo(id))
        .findAll();
    return managerTournamentStats;
  }

  @override
  Future<ManagerTournamentStat> saveManagerTournamentStat(
      ManagerTournamentStat managerTournamentStat) async {
    final isar = await db;
    final newID = isar.writeTxnSync<int>(
        () => isar.managerTournamentStats.putSync(managerTournamentStat));
    managerTournamentStat.id = newID;
    return managerTournamentStat;
  }

  @override
  Future<bool> updateManagerTournamentStats(
      Id id, ManagerTournamentStat managerTournamentStat) async {
    final isar = await db;
    final originalManagerTournamentStat =
        await isar.managerTournamentStats.get(id);
    if (originalManagerTournamentStat == null) return false;
    originalManagerTournamentStat.finalPosition =
        managerTournamentStat.finalPosition;
    isar.writeTxnSync(() =>
        isar.managerTournamentStats.putSync(originalManagerTournamentStat));
    return true;
  }

  @override
  Future<List<ManagerTournamentStat>> loadNextPage(
      {int limit = 10, offset = 10}) async {
    final isar = await db;
    return isar.managerTournamentStats
        .where()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByDoubleKey(
      Id teamId, Id seasonId) async {
    final isar = await db;
    List<ManagerTournamentStat> result = [];
    result = await isar.managerTournamentStats
        .filter()
        .team((q) => q.idEqualTo(teamId))
        .season((q) => q.idEqualTo(seasonId))
        .findAll();
    return result;
  }

  @override
  Future<List<ManagerTournamentStat>> getManagerTournamentStatsByTeam(
      {int limit = 10, offset = 10, required Id id}) async {
    final isar = await db;
    final managerTournamentStats = await isar.managerTournamentStats
        .filter()
        .team((q) => q.idEqualTo(id))
        .findAll();
    return managerTournamentStats;
  }
}
