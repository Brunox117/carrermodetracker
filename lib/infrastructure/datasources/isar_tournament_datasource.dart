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
  Future<bool> deleteTournament(Id id) {
    // TODO: implement deleteTournament
    throw UnimplementedError();
  }

  @override
  Future<Tournament> getTournament(Id id) {
    // TODO: implement getTournament
    throw UnimplementedError();
  }

  @override
  Future<List<Tournament>> getTournaments({int limit = 10, offset = 0}) {
    // TODO: implement getTournaments
    throw UnimplementedError();
  }

  @override
  Future<bool> saveTournament(Tournament tournament) {
    // TODO: implement saveTournament
    throw UnimplementedError();
  }

  @override
  Future<bool> updateTournament(Id id, Tournament tournament) {
    // TODO: implement updateTournament
    throw UnimplementedError();
  }
}
