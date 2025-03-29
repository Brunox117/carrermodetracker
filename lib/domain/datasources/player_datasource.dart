import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:isar/isar.dart';

abstract class PlayerDatasource {
  Future<Player> savePlayer(Player player);

  Future<Player> getPlayer(Id id);

  Future<bool> deletePlayer(Id id);

  Future<List<Player>> getPlayersByTeam(Id teamId);

  Future<bool> updatePlayer(Id id, Player player);
}
