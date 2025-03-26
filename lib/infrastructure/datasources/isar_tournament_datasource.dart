import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/tournament_datasource.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:isar/isar.dart';

class IsarTournamentDatasource extends TournamentDatasource {
  late Future<Isar> db;
  IsarTournamentDatasource() {
    db = openDB(TournamentSchema);
  }
  @override
  Future<bool> deleteTournament(Id id) async {
    final isar = await db;
    final tournament =
        await isar.tournaments.filter().idEqualTo(id).findFirst();
    if (tournament != null) {
      isar.writeTxnSync(() => isar.tournaments.deleteSync(id));
      return true;
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
  Future<bool> saveTournament(Tournament tournament) async {
    final isar = await db;
    isar.writeTxn(() async {
      await isar.tournaments.put(tournament);
      await tournament.stats.save();
    });
    return true;
  }

  @override
  Future<bool> updateTournament(Id id, Tournament tournament) async {
    final isar = await db;
    final originalTournament = await isar.tournaments.get(id);
    if (originalTournament != null) {
      originalTournament.logoURL = tournament.logoURL;
      originalTournament.name = tournament.name;
    }
    return false;
  }
}
