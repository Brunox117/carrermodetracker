import 'package:carrermodetracker/config/helpers/open_db.dart';
import 'package:carrermodetracker/domain/datasources/player_datasource.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:isar/isar.dart';

class IsarPlayerDatasource extends PlayerDatasource {
  late Future<Isar> db;
  IsarPlayerDatasource() {
    db = openDB(PlayerSchema);
  }

  @override
  Future<bool> deletePlayer(Id id) async {
    final isar = await db;
    final player = await isar.players.filter().idEqualTo(id).findFirst();
    if (player != null) {
      isar.writeTxnSync(() => isar.players.deleteSync(id));
      return true;
    }
    return false;
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
        .team((q) => q.idEqualTo(teamId))
        .findAll();
  }

  @override
  Future<bool> savePlayer(Player player) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.players.put(player);
      await player.team.save();
    });
    return true;
  }

  @override
  Future<bool> updatePlayer(Id id, Player player) async {
    final isar = await db;
    final originalPlayer = await isar.players.get(id);
    if (originalPlayer == null) return false;
    originalPlayer.name = player.name;
    originalPlayer.number = player.number;
    originalPlayer.position = player.position;
    originalPlayer.imageURL = player.imageURL;
    isar.writeTxnSync(() => isar.players.putSync(originalPlayer));
    return true;
  }
}
