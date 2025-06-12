import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PlayerIndividualStats extends ConsumerWidget {
  final String playerId;
  final String teamId;
  const PlayerIndividualStats(
      {super.key, required this.playerId, required this.teamId});

  @override
  Widget build(BuildContext context, ref) {
    final textStyles = Theme.of(context).textTheme;
    final statsProv = ref.watch(statsProvider.notifier);
    final statsFromPlayer = ref
        .watch(statsProvider)
        .values
        .where(
          (stat) => stat.player.value?.id == int.parse(playerId),
        )
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Estadísticas'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Estadísticas registradas para el jugador',
                style: textStyles.bodyLarge,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: statsFromPlayer.length,
                itemBuilder: (context, index) {
                  final stat = statsFromPlayer[index];
                  return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Row(
                          children: [
                            Text(
                                "${stat.season.value!.season.toString()} ${stat.tournament.value!.name}"),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  //TODO obtener el id del equipo desde stat
                                  context.go(
                                      '/teamoverview/${stat.team.value?.id}/addstatview?seasonId=${stat.season.value?.id}&playerId=${stat.player.value?.id}&tournamentId=${stat.tournament.value?.id}&pastTeamId=${stat.team.value?.id}');
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  statsProv.deleteStats(stat.id);
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ));
                },
              ),
            ),
          ],
        ));
  }
}
