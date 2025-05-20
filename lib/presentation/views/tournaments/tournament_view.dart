import 'dart:io';

import 'package:carrermodetracker/config/helpers/show_default_dialog.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/shared/best_stats_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
          //Get best 5 players for each stat
          List<Map<String, dynamic>> top5PGoals =
              getTopScorers(statsByTournament.values.toList());
          List<Map<String, dynamic>> top5PAssists =
              getTopAssists(statsByTournament.values.toList());
          List<Map<String, dynamic>> top5PPlayedMatches =
              getTopPlayedMatches(statsByTournament.values.toList());

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
                          context.push('/edittournament/${tournament.id}');
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      const SizedBox(height: 1),
                      IconButton.filledTonal(
                        onPressed: () {
                          showDefaultDialog(
                              context,
                              "¿Estás seguro de que deseas borrar el torneo, borrarlo también va a borrar todas las estadísticas asociadas a este torneo?",
                              "Aceptar",
                              'Cancelar', () {
                            context.pop();
                          }, () async {
                            context.pop();
                            context.pop();
                            for (Stats stat in tournament.stats) {
                              ref
                                  .read(statsProvider.notifier)
                                  .deleteStats(stat.id);
                            }
                            ref
                                .read(tournamentsProvider.notifier)
                                .deleteTournament(int.parse(tournamentID));
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
                      'Los mejores',
                      style: textStyles.titleLarge?.copyWith(
                          color: colors.primary, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16.0),
                    BestStatsCard(
                      title: 'Máximos goleadores',
                      players: top5PGoals,
                      statKey: 'goals',
                    ),
                    const SizedBox(height: 16.0),
                    BestStatsCard(
                      title: 'Máximos asistentes',
                      players: top5PAssists,
                      statKey: 'assists',
                    ),
                    const SizedBox(height: 16.0),
                    BestStatsCard(
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
