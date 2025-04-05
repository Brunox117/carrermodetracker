import 'package:carrermodetracker/config/helpers/image_utilities.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/repositories/player_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/players_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> addPlayer(Player player, XFile? imageFile) async {
    final playerWId = await playerStorageRepository.savePlayer(player);
    if (imageFile != null) {
      playerWId.imageURL = await saveImageInLocalStorage(
          imageFile, 'players', playerWId.id.toString());
      await playerStorageRepository.updatePlayer(playerWId.id, playerWId);
    }
    state = {...state, playerWId.id: playerWId};
  }

  Future<Player> getPlayer(int id) async {
    Player player = await playerStorageRepository.getPlayer(id);
    state = {...state, player.id: player};
    return player;
  }

  Future<void> updatePlayer(int id, Player player, XFile? imageFile) async {
    await playerStorageRepository.updatePlayer(id, player);
    state = {...state, player.id: player};
  }

  Future<void> deletePlayer(int id) async {
    await playerStorageRepository.deletePlayer(id);
    state = {...state}..remove(id);
  }
}
