import 'dart:io';

import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/shared/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

          // Convertir el mapa a una lista de jugadores con sus goles
          List<Map<String, dynamic>> playersList =
              statsByTournament.values.toList();
          List<Map<String, dynamic>> top5PGoals = getTopScorers(playersList);
          List<Map<String, dynamic>> top5PAssists = getTopScorers(playersList);
          List<Map<String, dynamic>> top5PPlayedMatches =
              getTopScorers(playersList);

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
                  CustomCard(
                      child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Máximos goleadores',
                            style: textStyles.titleMedium,
                          ),
                          Column(
                            children: top5PGoals
                                .map((player) => Text(
                                      '${player['name']}: ${player['goals']}',
                                      style: textStyles.bodyMedium,
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    ],
                  )),
                  CustomCard(
                      child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Máximos asistentes',
                            style: textStyles.titleMedium,
                          ),
                          // Mostrar la lista de los 5 máximos goleadores
                          Column(
                            children: top5PGoals
                                .map((player) => Text(
                                      '${player['name']}: ${player['assists']}',
                                      style: textStyles.bodyMedium,
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    ],
                  )),
                  CustomCard(
                      child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Más participaciones',
                            style: textStyles.titleMedium,
                          ),
                          Column(
                            children: top5PGoals
                                .map((player) => Text(
                                      '${player['name']}: ${player['playedMatches']}',
                                      style: textStyles.bodyMedium,
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
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
