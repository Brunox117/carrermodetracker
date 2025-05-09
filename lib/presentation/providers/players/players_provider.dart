import 'dart:io';

import 'package:carrermodetracker/config/helpers/image_utilities.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/repositories/player_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/players_storage_provider.dart';
import 'package:flutter/material.dart';
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

final singlePlayerProvider = FutureProvider.autoDispose.family<Player, int>(
  (ref, id) {
    final playersMap = ref.watch(playersProvider);
    if (playersMap.containsKey(id)) {
      return playersMap[id]!;
    }
    return ref.read(playersProvider.notifier).getPlayer(id);
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
    Player oldPlayer = await playerStorageRepository.getPlayer(id);
    player.id = oldPlayer.id;
    if (imageFile != null) {
      if (oldPlayer.imageURL.isNotEmpty) {
        PaintingBinding.instance.imageCache
            .evict(FileImage(File(oldPlayer.imageURL)));
        await deleteImage(oldPlayer.imageURL);
      }
      player.imageURL =
          await saveImageInLocalStorage(imageFile, 'players', id.toString());
    }
    await playerStorageRepository.updatePlayer(id, player);
    state = {...state, id: player};
  }

  Future<void> deletePlayer(int id) async {
    //Give some time to return to club view and avoid no player exception
    Future.delayed(
      const Duration(milliseconds: 350),
      () async {
        await playerStorageRepository.deletePlayer(id);
        state = {...state}..remove(id);
      },
    );
  }
}
