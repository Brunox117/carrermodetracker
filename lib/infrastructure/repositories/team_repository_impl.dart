import 'package:carrermodetracker/domain/datasources/team_datasource.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/repositories/team_repository.dart';
import 'package:isar/isar.dart';

class TeamRepositoryImpl extends TeamRepository {
  final TeamDatasource datasource;

  TeamRepositoryImpl({required this.datasource});

  @override
  Future<bool> deleteTeam(Id id) {
    return datasource.deleteTeam(id);
  }

  @override
  Future<Team> getTeam(Id id) {
    return datasource.getTeam(id);
  }

  @override
  Future<List<Team>> getTeams({int limit = 10, offset = 0}) {
    return datasource.getTeams(limit: limit, offset: offset);
  }

  @override
  Future<bool> saveTeam(Team team) {
    return datasource.saveTeam(team);
  }

  @override
  Future<bool> updateTeam(Id id, Team team) {
    return datasource.updateTeam(id, team);
  }
}
