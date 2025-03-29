import 'package:carrermodetracker/domain/datasources/player_datasource.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/repositories/player_repository.dart';
import 'package:isar/isar.dart';

class PlayerRepositoryImpl extends PlayerRepository {
  final PlayerDatasource datasource;

  PlayerRepositoryImpl({required this.datasource});

  @override
  Future<bool> deletePlayer(Id id) {
    return datasource.deletePlayer(id);
  }

  @override
  Future<Player> getPlayer(Id id) {
    return datasource.getPlayer(id);
  }

  @override
  Future<List<Player>> getPlayersByTeam(Id teamId) {
    return datasource.getPlayersByTeam(teamId);
  }

  @override
  Future<Player> savePlayer(Player player) {
    return datasource.savePlayer(player);
  }

  @override
  Future<bool> updatePlayer(Id id, Player player) {
    return datasource.updatePlayer(id, player);
  }
}