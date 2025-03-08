import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/repositories/player_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/players_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playersProvider =
    StateNotifierProvider<StoragePlayersNotifier, Map<int, Player>>(
  (ref) {
    final playerStorageRepository = ref.watch(playersStorageProvider);
    return StoragePlayersNotifier(
        playerStorageRepository: playerStorageRepository);
  },
);

class StoragePlayersNotifier extends StateNotifier<Map<int, Player>> {
  final PlayerRepository playerStorageRepository;

  StoragePlayersNotifier({required this.playerStorageRepository}) : super({});

  Future<List<Player>> getPlayersByTeam(int teamId) async {
    final players = await playerStorageRepository.getPlayersByTeam(teamId);
    final tempPlayersMap = <int, Player>{};
    for (final player in players) {
      tempPlayersMap[player.id] = player;
    }
    state = {...state, ...tempPlayersMap};
    return players;
  }

  Future<void> addPlayer(Player player) async {
    await playerStorageRepository.savePlayer(player);
    state = {...state, player.id: player};
  }

  Future<Player> getPlayer(int id) async {
    Player player = await playerStorageRepository.getPlayer(id);
    return player;
  }
}
