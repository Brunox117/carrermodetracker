import 'package:carrermodetracker/presentation/providers/manager/managers_provider.dart';
import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/infrastructure/datasources/isar_manager_tournament_stat_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

final managerTournamentStatDatasourceProvider = Provider((ref) {
  return IsarManagerTournamentStatDatasource();
});

class DtGeneralView extends ConsumerWidget {
  const DtGeneralView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(managersProvider);
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi perfil"),
      ),
      body: (manager == null)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'No has creado tu perfil de entrenador aún',
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.push('/dtview/addDt');
                  },
                  child: const Text('Crear perfil'),
                ),
              ],
            )
          : Scaffold(
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
                            context.push('/dtview/editdt/${manager.id}');
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        const SizedBox(height: 1),
                        IconButton.filledTonal(
                          onPressed: () {
                            context.push('/dtview/adddtstats/${manager.id}');
                          },
                          icon: const Icon(Icons.add_chart_rounded),
                        ),
                        const SizedBox(height: 1),
                      ],
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (manager.imageUrl.isNotEmpty)
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(File(manager.imageUrl)),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        manager.name,
                        style: textStyles.titleLarge?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estadísticas Generales',
                                style: textStyles.titleMedium?.copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Builder(
                                builder: (context) {
                                  final stats = manager.managerStats.value;
                                  if (stats == null) {
                                    return const Center(
                                      child: Text(
                                          'No hay estadísticas disponibles'),
                                    );
                                  }

                                  return Column(
                                    children: [
                                      _buildStatRow('Partidos Jugados',
                                          stats.playedMatches.toString()),
                                      _buildStatRow(
                                          'Victorias', stats.wins.toString()),
                                      _buildStatRow(
                                          'Empates', stats.draws.toString()),
                                      _buildStatRow(
                                          'Derrotas', stats.loses.toString()),
                                      _buildStatRow('Goles Marcados',
                                          stats.goalsScored.toString()),
                                      _buildStatRow('Goles Recibidos',
                                          stats.goalsConceded.toString()),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Torneos',
                                style: textStyles.titleMedium?.copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              FutureBuilder<List<ManagerTournamentStat>>(
                                future: ref
                                    .read(
                                        managerTournamentStatDatasourceProvider)
                                    .getManagerTournamentStatsByManager(
                                        id: manager.id),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  final tournaments = snapshot.data!;
                                  if (tournaments.isEmpty) {
                                    return const Center(
                                      child: Text('No hay torneos disponibles'),
                                    );
                                  }

                                  return Column(
                                    children: tournaments.map((tournament) {
                                      return ListTile(
                                        title: Text(
                                            tournament.tournament.value?.name ??
                                                ''),
                                        subtitle: Text(
                                            'Posición: ${tournament.finalPosition}'),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
