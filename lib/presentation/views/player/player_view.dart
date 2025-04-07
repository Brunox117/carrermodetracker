import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerView extends ConsumerWidget {
  final String playerID;
  const PlayerView({super.key, required this.playerID});

  @override
  Widget build(BuildContext context, ref) {
    final playerAsync = ref.watch(singlePlayerProvider(int.parse(playerID)));
    return playerAsync.when(
      data: (player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(player.name),
          ),
          body: const Center(
            child: Text('PlayerView'),
          ),
        );
      },
      error: (error, stackTrace) => const Text('Algo salió mal :('),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
