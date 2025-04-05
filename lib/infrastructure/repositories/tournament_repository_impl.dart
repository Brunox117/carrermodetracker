import 'package:carrermodetracker/domain/datasources/tournament_datasource.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/domain/repositories/tournament_repository.dart';
import 'package:isar/isar.dart';

class TournamentRepositoryImpl extends TournamentRepository {
  final TournamentDatasource datasource;

  TournamentRepositoryImpl({required this.datasource});
  @override
  Future<bool> deleteTournament(Id id) {
    return datasource.deleteTournament(id);
  }

  @override
  Future<Tournament> getTournament(Id id) {
    return datasource.getTournament(id);
  }

  @override
  Future<List<Tournament>> getTournaments({int limit = 10, int offset = 0}) {
    return datasource.getTournaments(limit: limit, offset: offset);
  }

  @override
  Future<Tournament> saveTournament(Tournament tournament) {
    return datasource.saveTournament(tournament);
  }

  @override
  Future<bool> updateTournament(Id id, Tournament tournament) {
    return datasource.updateTournament(id, tournament);
  }
}
