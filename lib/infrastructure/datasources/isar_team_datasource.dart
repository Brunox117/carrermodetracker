import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/team_datasource.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:isar/isar.dart';

class IsarTeamDatasource extends TeamDatasource {
  late Future<Isar> db;
  IsarTeamDatasource() {
    db = openDB([
      TeamSchema,
      PlayerSchema,
      StatsSchema,
      SeasonSchema,
      TournamentSchema
    ]);
  }

  @override
  Future<bool> deleteTeam(Id id) async {
    final isar = await db;
    final team = await isar.teams.filter().idEqualTo(id).findFirst();
    if (team != null) {
      isar.writeTxn(() => isar.teams.delete(id));
      return true;
    }
    return false;
  }

  @override
  Future<Team> getTeam(Id id) async {
    final isar = await db;
    final Team? team = await isar.teams.get(id);
    if (team != null) return team;
    //NO DEBERIA DARSE PORQUE EL USUARIO NO INGRESA EL ID MANUALMENTE
    throw 'El equipo no existe';
  }

  @override
  Future<List<Team>> getTeams({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.teams.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<Team> saveTeam(Team team) async {
    final isar = await db;
    final newID = isar.writeTxnSync<int>(() => isar.teams.putSync(team));
    team.id = newID;
    return team;
  }

  @override
  Future<bool> updateTeam(Id id, Team team) async {
    final isar = await db;
    final originalTeam = await isar.teams.get(id);
    if (originalTeam == null) return false;
    originalTeam.name = team.name;
    originalTeam.acronimos = team.acronimos;
    originalTeam.logoURL = team.logoURL;
    isar.writeTxnSync(
      () => isar.teams.putSync(originalTeam),
    );
    return true;
  }
}
