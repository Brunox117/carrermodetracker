import 'dart:io';

import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/table_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TournamentView extends ConsumerWidget {
  final String tournamentID;
  const TournamentView({super.key, required this.tournamentID});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final tournamentAsync =
        ref.watch(singleTournamentProvider(int.parse(tournamentID)));

    return tournamentAsync.when(
        data: (tournament) {
          final Map<int, Map<String, dynamic>> statsByTournament = {};

          populateStatsByTournament(
              tournament.stats.toList(), statsByTournament);

          final List<TableRow> playersRows =
              statsByTournament.values.map((playerStat) {
            return TableRow(
              children: [
                TableCell(
                  child: GestureDetector(
                      child: TableText(playerStat['name'].toString())),
                ),
                TableCell(
                  child: TableText(playerStat['playedMatches'].toString()),
                ),
                TableCell(
                  child: TableText(playerStat['goals'].toString()),
                ),
                TableCell(
                  child: TableText(playerStat['assists'].toString()),
                ),
              ],
            );
          }).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text(tournament.name),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  (tournament.logoURL.isEmpty)
                      ? const SizedBox()
                      : SizedBox(
                          height: 200,
                          child: Image.file(
                            File(tournament.logoURL),
                            fit: BoxFit.contain,
                          ),
                        ),
                  Text(
                    'Mejores jugadores',
                    style: textStyles.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Table(
                      columnWidths: const {
                        0: FlexColumnWidth(4), // Jugador
                        1: FlexColumnWidth(1), // PJ
                        2: FlexColumnWidth(1), // G
                        3: FlexColumnWidth(1), // A
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                                color: colors.secondary.withValues(alpha: 0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            children: const [
                              TableCell(
                                  child: TableText(
                                'Jugador',
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
                        ...playersRows,
                      ])
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => const Center(
              child: Text(
                  'Hubo un error al cargar el torneo, intentalo de nuevo más tarde'),
            ),
        loading: () => const CircularProgressIndicator());
  }

  //Builds a list of stats for each player
  void populateStatsByTournament(List<Stats> statsFromTournament,
      Map<int, Map<String, dynamic>> statsByPlayer) {
    for (final stat in statsFromTournament) {
      final Player? player = stat.player.value;
      if (player != null) {
        final int playerId = player.id;
        if (statsByPlayer.containsKey(playerId)) {
          statsByPlayer[playerId]!['playedMatches'] += stat.playedMatches;
          statsByPlayer[playerId]!['goals'] += stat.goals;
          statsByPlayer[playerId]!['assists'] += stat.assists;
        } else {
          statsByPlayer[playerId] = {
            'name': player.name,
            'playerId': player.id,
            'playedMatches': stat.playedMatches,
            'goals': stat.goals,
            'assists': stat.assists
          };
        }
      }
    }
  }
}
