import 'dart:io';

import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/shared/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TournamentView extends ConsumerWidget {
  final String tournamentID;
  const TournamentView({super.key, required this.tournamentID});

  @override
  Widget build(BuildContext context, ref) {
    final textStyles = Theme.of(context).textTheme;
    final tournamentAsync =
        ref.watch(singleTournamentProvider(int.parse(tournamentID)));

    return tournamentAsync.when(
        data: (tournament) {
          final Map<int, Map<String, dynamic>> statsByTournament = {};

          populateStatsByTournament(
              tournament.stats.toList(), statsByTournament);
          //Get best 5 players for each stat
          List<Map<String, dynamic>> top5PGoals =
              getTopScorers(statsByTournament.values.toList());
          List<Map<String, dynamic>> top5PAssists =
              getTopAssists(statsByTournament.values.toList());
          List<Map<String, dynamic>> top5PPlayedMatches =
              getTopPlayedMatches(statsByTournament.values.toList());

          return Scaffold(
            floatingActionButton: IconButton.filledTonal(
              onPressed: () {
                context.push('/edittournament/${tournament.id}');
              },
              icon: const Icon(Icons.edit),
            ),
            appBar: AppBar(
              title: Text(tournament.name),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
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
                      "Los mejores",
                      style: textStyles.titleLarge,
                    ),
                    const SizedBox(height: 16.0),
                    _PlayerStatsTableCard(
                      title: 'Máximos goleadores',
                      players: top5PGoals,
                      statKey: 'goals',
                    ),
                    const SizedBox(height: 16.0),
                    _PlayerStatsTableCard(
                      title: 'Máximos asistentes',
                      players: top5PAssists,
                      statKey: 'assists',
                    ),
                    const SizedBox(height: 16.0),
                    _PlayerStatsTableCard(
                      title: 'Más participaciones',
                      players: top5PPlayedMatches,
                      statKey: 'playedMatches',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
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

  List<Map<String, dynamic>> getTopScorers(
      List<Map<String, dynamic>> playersList) {
    playersList.sort((a, b) => b['goals'].compareTo(a['goals']));
    return playersList.take(5).toList();
  }

  List<Map<String, dynamic>> getTopAssists(
      List<Map<String, dynamic>> playersList) {
    playersList.sort((a, b) => b['assists'].compareTo(a['assists']));
    return playersList.take(5).toList();
  }

  List<Map<String, dynamic>> getTopPlayedMatches(
      List<Map<String, dynamic>> playersList) {
    playersList
        .sort((a, b) => b['playedMatches'].compareTo(a['playedMatches']));
    return playersList.take(5).toList();
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
            'imageURL': player.imageURL,
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

class _PlayerStatsTableCard extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> players;
  final String statKey;

  const _PlayerStatsTableCard({
    required this.title,
    required this.players,
    required this.statKey,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textStyles.titleMedium,
          ),
          const SizedBox(height: 8.0),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2), // Nombre
              1: FlexColumnWidth(1), // Stat
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              ...players.map((player) {
                return TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        player['name'],
                        style: textStyles.bodyMedium,
                      ),
                    ),
                    TableCell(
                      child: Text(
                        '${player[statKey]}',
                        style: textStyles.bodyMedium,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
