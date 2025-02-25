import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:isar/isar.dart';

abstract class TeamRepository {
  Future<bool> saveTeam(Team team);

  Future<Team> getTeam(Id id);

  Future<List<Team>> getTeams({int limit = 10, offset = 0});

  Future<bool> deleteTeam(Id id);

  Future<bool> updateTeam(Id id, Team team);
}
