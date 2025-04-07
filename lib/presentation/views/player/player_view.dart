import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
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

    final Map<int, Map<String, dynamic>> aggregatedStats = {};

    for (final stat in statsFromPlayer) {
      final Tournament? tournament = stat.tournament.value;

      if (tournament != null) {
        final int tournamentId = tournament.id;
        if (aggregatedStats.containsKey(tournamentId)) {
          // Si ya existe, suma las estadísticas
          aggregatedStats[tournamentId]!['playedMatches'] += stat.playedMatches;
          aggregatedStats[tournamentId]!['goals'] += stat.goals;
          aggregatedStats[tournamentId]!['assists'] += stat.assists;
        } else {
          // Si no existe, crea una nueva entrada
          aggregatedStats[tournamentId] = {
            'name': tournament.name, // Guardamos el nombre para mostrarlo
            'playedMatches': stat.playedMatches,
            'goals': stat.goals,
            'assists': stat.assists,
          };
        }
      }
    }

    // 2. Crear las TableRows a partir de las estadísticas agregadas y calcular totales
    int totalPlayedMatches = 0;
    int totalGoals = 0;
    int totalAssists = 0;

    final List<TableRow> statRows = aggregatedStats.values.map((aggStat) {
      // Sumar a los totales
      totalPlayedMatches += aggStat['playedMatches'] as int;
      totalGoals += aggStat['goals'] as int;
      totalAssists += aggStat['assists'] as int;

      // Crear la fila para este torneo
      return TableRow(
        children: [
          TableCell(
            // Usando TableText para consistencia, asumiendo que maneja el estilo
            child: TableText(aggStat['name'].toString()),
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

    final TableRow totalRow = TableRow(
      decoration: BoxDecoration(
          color: colors.primary.withOpacity(0.2),
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
                    0: FlexColumnWidth(4), // Competición
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
                    totalRow,
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
}
