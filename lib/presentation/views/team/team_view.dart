import 'dart:io';

import 'package:carrermodetracker/config/helpers/show_default_dialog.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:carrermodetracker/presentation/widgets/shared/best_stats_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class TeamView extends ConsumerWidget {
  final String id;
  const TeamView({super.key, required this.id});

  Map<String, int> getPlayerStats(Player player, List<Stats> teamStats) {
    int totalGoals = 0;
    int totalMatches = 0;
    int totalAssists = 0;

    final playerStats =
        teamStats.where((stat) => stat.player.value?.id == player.id).toList();

    for (var stat in playerStats) {
      totalGoals += stat.goals;
      totalAssists += stat.assists;
      totalMatches += stat.playedMatches;
    }

    return {
      'goals': totalGoals,
      'matches': totalMatches,
      'assists': totalAssists,
    };
  }

  List<Map<String, dynamic>> getTopPlayers(
      List<Player> players, List<Stats> teamStats, String statType) {
    players.sort((a, b) {
      var aStats = getPlayerStats(a, teamStats);
      var bStats = getPlayerStats(b, teamStats);
      return bStats[statType]!.compareTo(aStats[statType]!);
    });
    return players.take(3).map((player) {
      final stats = getPlayerStats(player, teamStats);
      return {
        'name': player.name,
        statType: stats[statType],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamAsync = ref.watch(teamProvider(int.parse(id)));
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: teamAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (team) {
          final players = ref
              .watch(playersProvider)
              .values
              .where((player) => player.teams.any((t) => t.id == team.id))
              .toList();
          final statsOfPlayers = ref
              .watch(statsProvider)
              .values
              .where((stat) => stat.team.value!.id == team.id)
              .toList();
          final topScorers = getTopPlayers(players, statsOfPlayers, 'goals');
          final topAssists = getTopPlayers(players, statsOfPlayers, 'assists');
          final mostPlayed = getTopPlayers(players, statsOfPlayers, 'matches');

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
                          context.push('/editteam/$id');
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      const SizedBox(height: 1),
                      IconButton.filledTonal(
                        onPressed: () {
                          showDefaultDialog(
                              context,
                              "¿Estás seguro de que deseas borrar el equipo? Esto borrara todas las estadísticas relacionadas al equipo",
                              "Aceptar",
                              'Cancelar', () {
                            context.pop();
                          }, () {
                            context.pop();
                            List<Player> playersToDelete =
                                team.players.toList();
                            List<Stats> statsToDelete = [];
                            for (Player player in playersToDelete) {
                              statsToDelete.addAll(player.stats.toList());
                            }
                            for (Stats stat in statsToDelete) {
                              ref
                                  .read(statsProvider.notifier)
                                  .deleteStats(stat.id);
                            }
                            // for (Player player in playersToDelete) {
                            //   ref
                            //       .read(playersProvider.notifier)
                            //       .deletePlayer(player.id);
                            // }
                            ref
                                .read(teamsProvider.notifier)
                                .deleteTeam(team.id);
                            context.pop();
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(team.name, style: textStyles.titleLarge)),
                    const SizedBox(height: 10),
                    if (team.logoURL.isNotEmpty)
                      SizedBox(
                        height: 200,
                        child: Image.file(
                          File(team.logoURL),
                          fit: BoxFit.contain,
                        ),
                      ),
                    const SizedBox(height: 20),
                    (topScorers.isEmpty &&
                            topAssists.isEmpty &&
                            mostPlayed.isEmpty)
                        ? const SizedBox()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Los mejores',
                                  style: textStyles.titleLarge?.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: BestStatsCard(
                                        title: 'Goleadores',
                                        players: topScorers,
                                        statKey: 'goals',
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: BestStatsCard(
                                        title: 'Asistencias',
                                        players: topAssists,
                                        statKey: 'assists',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                BestStatsCard(
                                  title: 'Más Partidos Jugados',
                                  players: mostPlayed,
                                  statKey: 'matches',
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 200,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
