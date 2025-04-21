import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/stats_datasource.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:isar/isar.dart';

class IsarStatsDatasource extends StatsDatasource {
  late Future<Isar> db;
  IsarStatsDatasource() {
    db = openDB([StatsSchema]);
  }

  @override
  Future<bool> deleteStats(Id id) async {
    final isar = await db;
    final stats = await isar.stats.filter().idEqualTo(id).findFirst();
    if (stats != null) {
      isar.writeTxnSync(() => isar.stats.deleteSync(id));
      return true;
    }
    return false;
  }

  @override
  Future<Stats> getStats(Id id) async {
    final isar = await db;
    final stat = await isar.stats.get(id);
    if (stat != null) {
      return stat;
    }
    throw 'Stat no existe';
  }

  @override
  Future<Stats> saveStats(Stats stats) async {
    final isar = await db;
    final newID = await isar.writeTxn<int>(() async {
      return await isar.stats.put(stats);
      //UPDATE RELATIONS
    });
    await isar.writeTxn(
      () async {
        await stats.player.save();
        await stats.season.save();
        await stats.tournament.save();
      },
    );
    stats.id = newID;
    return stats;
  }

  @override
  Future<bool> updateStats(Id id, Stats stats) async {
    final isar = await db;
    final originalStat = await isar.stats.get(id);
    if (originalStat == null) return false;
    originalStat.assists = stats.assists;
    originalStat.goals = stats.goals;
    originalStat.playedMatches = stats.playedMatches;
    isar.writeTxnSync(() => isar.stats.putSync(originalStat));
    return true;
  }

  @override
  Future<List<Stats>> getStatsByPlayer(
      {int limit = 10, offset = 0, required Id id}) async {
    final isar = await db;
    return await isar.stats.filter().player((q) => q.idEqualTo(id)).findAll();
  }

  @override
  Future<List<Stats>> getStatsBySeason(
      {int limit = 10, offset = 0, required Id id}) async {
    final isar = await db;
    return await isar.stats
        .filter()
        .season(
          (q) => q.idEqualTo(id),
        )
        .findAll();
  }

  @override
  Future<List<Stats>> getStatsByTournament(
      {int limit = 10, offset = 0, required Id id}) async {
    final isar = await db;
    return await isar.stats
        .filter()
        .tournament(
          (q) => q.idEqualTo(id),
        )
        .findAll();
  }

  @override
  Future<Stats?> getStatByTripleKey(
      Id playerId, Id tournamentId, Id seasonId) async {
    final isar = await db;
    return await isar.stats
        .filter()
        .player((q) => q.idEqualTo(playerId))
        .season((q) => q.idEqualTo(seasonId))
        .tournament((q) => q.idEqualTo(tournamentId))
        .findFirst();
  }
}
