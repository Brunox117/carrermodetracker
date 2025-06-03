import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/presentation/providers/manager/managers_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_tournament_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

class DtGeneralView extends ConsumerStatefulWidget {
  const DtGeneralView({super.key});

  @override
  DtGeneralViewState createState() => DtGeneralViewState();
}

class DtGeneralViewState extends ConsumerState<DtGeneralView> {
  Map<String, int> managerTotalStats = {};

  @override
  void initState() {
    super.initState();
    ref.read(managerStatsProvider.notifier).loadNextPage();
    ref.read(managerTournamentStatsProvider.notifier).loadNextPage();
  }

  Map<String, int> calculateManagerTotalStats(List<Managerstat> managerStats) {
    return managerStats.fold<Map<String, int>>(
      {
        'playedMatches': 0,
        'wins': 0,
        'loses': 0,
        'draws': 0,
        'goalsScored': 0,
        'goalsConceded': 0,
      },
      (stats, managerStat) => {
        'playedMatches': stats['playedMatches']! + managerStat.playedMatches,
        'wins': stats['wins']! + managerStat.wins,
        'loses': stats['loses']! + managerStat.loses,
        'draws': stats['draws']! + managerStat.draws,
        'goalsScored': stats['goalsScored']! + managerStat.goalsScored,
        'goalsConceded': stats['goalsConceded']! + managerStat.goalsConceded,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.watch(managersProvider);
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final managerStats = ref.watch(managerStatsProvider).values.toList();
    final managerTournamentStats =
        ref.watch(managerTournamentStatsProvider);

    //Get total stats
    managerTotalStats = calculateManagerTotalStats(managerStats);
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
                              (managerStats.isEmpty)
                                  ? const Center(
                                      child: Text(
                                          'No hay estadísticas disponibles'),
                                    )
                                  : Column(
                                      children: [
                                        _buildStatRow(
                                            "Partidos jugados",
                                            managerTotalStats["playedMatches"]
                                                .toString()),
                                        _buildStatRow(
                                            "Victorias",
                                            managerTotalStats["wins"]
                                                .toString()),
                                        _buildStatRow(
                                            "Derrotas",
                                            managerTotalStats["loses"]
                                                .toString()),
                                        _buildStatRow(
                                            "Empates",
                                            managerTotalStats["draws"]
                                                .toString()),
                                        _buildStatRow(
                                            "Goles anotados",
                                            managerTotalStats["goalsScored"]
                                                .toString()),
                                        _buildStatRow(
                                            "Goles concedidos",
                                            managerTotalStats["goalsConceded"]
                                                .toString())
                                      ],
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
                              (managerTournamentStats.isEmpty)
                                  ? const Center(
                                      child: Text(
                                          'No hay estadísticas disponibles'),
                                    )
                                  : const SizedBox()
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
