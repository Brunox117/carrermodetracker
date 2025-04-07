import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/table_text.dart';
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
    final colors = Theme.of(context).colorScheme;
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3), // Competición
                    1: FlexColumnWidth(1), // PJ
                    2: FlexColumnWidth(1), // G
                    3: FlexColumnWidth(1), // A
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                        decoration: BoxDecoration(
                            color: colors.secondary.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        children: const [
                          TableCell(
                              child: TableText(
                            'Competición',
                            isHeader: true,
                          )),
                          TableCell(
                              child: TableText(
                            'P',
                            isHeader: true,
                          )),
                          TableCell(
                              child: TableText(
                            'G',
                            isHeader: true,
                          )),
                          TableCell(
                              child: TableText(
                            'A',
                            isHeader: true,
                          )),
                        ]),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => const Text('Algo salió mal :('),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
