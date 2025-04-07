import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PlayerView extends ConsumerStatefulWidget {
  final String playerID;
  const PlayerView({super.key, required this.playerID});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayerViewState();
}

class _PlayerViewState extends ConsumerState<PlayerView> {
  void loadStats() async {
    ref
        .read(statsProvider.notifier)
        .getStatsByPlayer(id: int.parse(widget.playerID));
  }

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  @override
  Widget build(BuildContext context) {
    final playerAsync =
        ref.watch(singlePlayerProvider(int.parse(widget.playerID)));
    final statsFromPlayer = ref
        .watch(statsProvider)
        .values
        .where(
          (stat) => stat.player.value!.id == int.parse(widget.playerID),
        )
        .toList();
    return playerAsync.when(
      data: (player) {
        return Scaffold(
          floatingActionButton: IconButton.filledTonal(
            onPressed: () {
              context.push('/editplayer/${widget.playerID}');
            },
            icon: const Icon(Icons.edit),
          ),
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
