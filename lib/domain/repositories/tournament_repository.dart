import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:isar/isar.dart';

abstract class TournamentRepository {
  Future<Tournament> saveTournament(Tournament tournament);

  Future<Tournament> getTournament(Id id);

  Future<List<Tournament>> getTournaments({int limit = 10, int offset = 0});

  Future<bool> deleteTournament(Id id);

  Future<bool> updateTournament(Id id, Tournament tournament);
}
