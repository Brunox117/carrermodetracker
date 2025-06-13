import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/player_datasource.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:isar/isar.dart';

class IsarPlayerDatasource extends PlayerDatasource {
  late Future<Isar> db;
  IsarPlayerDatasource() {
    db = openDB([PlayerSchema, StatsSchema]);
  }

  @override
  Future<bool> deletePlayer(Id id) async {
    final isar = await db;
    return await isar.writeTxn<bool>(() async {
      await isar.stats.filter().player((q) => q.idEqualTo(id)).deleteAll();
      return await isar.players.delete(id);
    });
  }

  @override
  Future<Player> getPlayer(Id id) async {
    final isar = await db;
    final player = await isar.players.get(id);
    if (player != null) {
      return player;
    }
    throw 'El jugador no existe';
  }

  @override
  Future<List<Player>> getPlayersByTeam(Id teamId) async {
    final isar = await db;
    return await isar.players
        .filter()
        .teams((q) => q.idEqualTo(teamId))
        .findAll();
  }

  @override
  Future<Player> savePlayer(Player player) async {
    final isar = await db;
    final newID = await isar.writeTxn<int>(() async {
      return await isar.players.put(player);
    });
    await isar.writeTxn(
      () async {
        await player.teams.save();
      },
    );
    player.id = newID;
    return player;
  }

  @override
  Future<bool> updatePlayer(Id id, Player player) async {
    final isar = await db;
    final originalPlayer = await isar.players.get(id);
    if (originalPlayer == null) return false;

    return await isar.writeTxn(() async {
      await originalPlayer.teams.reset();
      originalPlayer.name = player.name;
      originalPlayer.number = player.number;
      originalPlayer.position = player.position;
      originalPlayer.imageURL = player.imageURL;
      await originalPlayer.teams.load();
      for (final team in player.teams) {
        originalPlayer.teams.add(team);
      }
      await originalPlayer.teams.save();
      await isar.players.put(originalPlayer);
      return true;
    });
  }
}
