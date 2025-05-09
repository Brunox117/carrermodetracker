import 'package:carrermodetracker/config/helpers/show_default_dialog.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:carrermodetracker/presentation/widgets/shared/table_row_divider.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/table_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';

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
          (stat) => stat.player.value?.id == int.parse(widget.playerID),
        )
        .toList();
    final Map<int, Map<String, dynamic>> statsByTournament = {};
    int totalPlayedMatches = 0;
    int totalGoals = 0;
    int totalAssists = 0;

    //Populate stats by tournament ex(La Liga, 40, 10, 3)
    populateStatsByTournament(statsFromPlayer, statsByTournament);

    //Build row per stats by tournament also register total stats
    final List<TableRow> statRows = statsByTournament.values.map((aggStat) {
      totalPlayedMatches += aggStat['playedMatches'] as int;
      totalGoals += aggStat['goals'] as int;
      totalAssists += aggStat['assists'] as int;

      return TableRow(
        children: [
          TableCell(
            child: GestureDetector(
                onTap: () =>
                    context.push('/tournamentview/${aggStat['tournamentId']}'),
                child: TableText(aggStat['name'].toString())),
          ),
          TableCell(
            child: TableText(aggStat['playedMatches'].toString()),
          ),
          TableCell(
            child: TableText(aggStat['goals'].toString()),
          ),
          TableCell(
            child: TableText(aggStat['assists'].toString()),
          ),
        ],
      );
    }).toList();

    //Build totals row
    final TableRow totalsRow = TableRow(
      decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.3),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      children: [
        const TableCell(
          child: TableText(
            'Totales',
            isHeader: true,
          ),
        ),
        TableCell(
          child: TableText(
            totalPlayedMatches.toString(),
            isHeader: true,
          ),
        ),
        TableCell(
          child: TableText(
            totalGoals.toString(),
            isHeader: true,
          ),
        ),
        TableCell(
          child: TableText(
            totalAssists.toString(),
            isHeader: true,
          ),
        ),
      ],
    );

    return playerAsync.when(
      data: (player) {
        return Scaffold(
          floatingActionButton: Stack(
            children: [
              Positioned(
                bottom: 16,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton.filledTonal(
                      onPressed: () {
                        context.push('/editplayer/${player.id}');
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    const SizedBox(height: 1),
                    IconButton.filledTonal(
                      onPressed: () {
                        context.push('/playerindividualstats/${player.id}');
                      },
                      icon: const Icon(Icons.add_chart_rounded),
                    ),
                    const SizedBox(height: 1),
                    IconButton.filledTonal(
                      onPressed: () {
                        showDefaultDialog(
                            context,
                            "¿Estás seguro de que deseas borrar el jugador?",
                            "Aceptar",
                            'Cancelar', () {
                          context.pop();
                        }, () {
                          context.pop();
                          context.pop();

                          ref
                              .read(playersProvider.notifier)
                              .deletePlayer(int.parse(widget.playerID));
                        });
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ],
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
                    0: FlexColumnWidth(4), // Competición
                    1: FlexColumnWidth(1), // PJ
                    2: FlexColumnWidth(1), // G
                    3: FlexColumnWidth(1), // A
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                        decoration: BoxDecoration(
                            color: colors.secondary.withValues(alpha: 0.2),
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
                            'J',
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
                    ...statRows,
                    tableRowDivider(
                        4,
                        const TableCell(
                            child: SizedBox(
                          height: 20,
                        ))),
                    totalsRow,
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => Text('Algo salió mal :( $error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  void populateStatsByTournament(List<Stats> statsFromPlayer,
      Map<int, Map<String, dynamic>> statsByTournament) {
    for (final stat in statsFromPlayer) {
      final Tournament? tournament = stat.tournament.value;
      if (tournament != null) {
        final int tournamentId = tournament.id;
        if (statsByTournament.containsKey(tournamentId)) {
          statsByTournament[tournamentId]!['playedMatches'] +=
              stat.playedMatches;
          statsByTournament[tournamentId]!['goals'] += stat.goals;
          statsByTournament[tournamentId]!['assists'] += stat.assists;
        } else {
          statsByTournament[tournamentId] = {
            'name': tournament.name,
            'tournamentId': tournament.id,
            'playedMatches': stat.playedMatches,
            'goals': stat.goals,
            'assists': stat.assists,
          };
        }
      }
    }
  }
}
