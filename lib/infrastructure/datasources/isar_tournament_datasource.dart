import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/tournament_datasource.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:isar/isar.dart';

class IsarTournamentDatasource extends TournamentDatasource {
  late Future<Isar> db;
  IsarTournamentDatasource() {
    db = openDB([TournamentSchema, StatsSchema]);
  }
  @override
  Future<bool> deleteTournament(Id id) async {
    final isar = await db;
    final tournament =
        await isar.tournaments.filter().idEqualTo(id).findFirst();
    if (tournament != null) {
     return await isar.writeTxn(
        () async {
          await isar.stats
              .filter()
              .tournament((q) => q.idEqualTo(id))
              .deleteAll();
          return await isar.tournaments.delete(id);
        },
      );
    }
    return false;
  }

  @override
  Future<Tournament> getTournament(Id id) async {
    final isar = await db;
    final tournament = await isar.tournaments.get(id);
    if (tournament != null) {
      return tournament;
    }
    throw 'El torneo no existe';
  }

  @override
  Future<List<Tournament>> getTournaments({int limit = 10, offset = 0}) async {
    final isar = await db;
    return await isar.tournaments.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<Tournament> saveTournament(Tournament tournament) async {
    final isar = await db;
    final newID = await isar.writeTxn<int>(() async {
      return await isar.tournaments.put(tournament);
    });
    isar.writeTxn(
      () async {
        await tournament.stats.save();
      },
    );
    tournament.id = newID;
    return tournament;
  }

  @override
  Future<bool> updateTournament(Id id, Tournament tournament) async {
    final isar = await db;
    final originalTournament = await isar.tournaments.get(id);
    if (originalTournament != null) {
      originalTournament.logoURL = tournament.logoURL;
      originalTournament.name = tournament.name;
      isar.writeTxnSync(() => isar.tournaments.putSync(originalTournament));
    }
    return false;
  }
}
