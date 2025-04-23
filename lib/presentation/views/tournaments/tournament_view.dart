import 'dart:io';

import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TournamentView extends ConsumerWidget {
  final String tournamentID;
  const TournamentView({super.key, required this.tournamentID});

  @override
  Widget build(BuildContext context, ref) {
    final tournamentAsync =
        ref.watch(singleTournamentProvider(int.parse(tournamentID)));
    return tournamentAsync.when(
        data: (tournament) {
          final Map<int, Map<String, dynamic>> statsByTournament = {};
          populateStatsByTournament(
              tournament.stats.toList(), statsByTournament);
          return Scaffold(
            appBar: AppBar(
              title: Text(tournament.name),
            ),
            body: Column(
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
              ],
            ),
          );
        },
        error: (error, stackTrace) => const Center(
              child: Text(
                  'Hubo un error al cargar el torneo, intentalo de nuevo más tarde'),
            ),
        loading: () => const CircularProgressIndicator());
  }

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
