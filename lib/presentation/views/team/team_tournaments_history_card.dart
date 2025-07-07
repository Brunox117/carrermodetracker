import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:flutter/material.dart';

class TeamTournamentsHistoryCard extends StatelessWidget {
  final List<ManagerTournamentStat> managerTournamentStats;
  const TeamTournamentsHistoryCard(
      {super.key, required this.managerTournamentStats});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final Map<String, List<Map<String, dynamic>>> statsBySeason = {};
    populateStatsBySeason(managerTournamentStats, statsBySeason);
    final statsBySeasonList = statsBySeason.entries.toList();

    // Sort seasons in descending order (most recent first)
    statsBySeasonList.sort((a, b) => b.key.compareTo(a.key));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Historial',
                style: textStyles.titleLarge?.copyWith(
                    color: colors.primary, fontWeight: FontWeight.w700),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: statsBySeasonList.length,
                itemBuilder: (context, index) {
                  final seasonEntry = statsBySeasonList[index];
                  final season = seasonEntry.key;
                  final tournamentsPlayedInSeason = seasonEntry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Season header
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          season,
                          style: textStyles.titleMedium?.copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Tournaments in this season
                      ...tournamentsPlayedInSeason.map((tournamentStat) {
                        final isWinner = tournamentStat['isWinner'] as bool;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isWinner
                                ? colors.primaryContainer.withValues(alpha: 0.3)
                                : colors.surfaceContainerHighest
                                    .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(8.0),
                            border: isWinner
                                ? Border.all(color: colors.primary, width: 2.0)
                                : null,
                          ),
                          child: Row(
                            children: [
                              // Tournament info
                              Expanded(
                                child: Text(
                                  "${tournamentStat['tournamentName']}",
                                  style: textStyles.bodyMedium?.copyWith(
                                    fontWeight: isWinner
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isWinner ? colors.primary : null,
                                  ),
                                ),
                              ),
                              (isWinner)
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: colors.primary,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Text(
                                        'GANADOR',
                                        style: textStyles.labelSmall?.copyWith(
                                          color: colors.onPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: colors.surfaceContainerHighest,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: colors.outline
                                              .withValues(alpha: 0.5),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Text(
                                        "${tournamentStat['finalPosition']}",
                                        style: textStyles.labelSmall?.copyWith(
                                          color: colors.onSurfaceVariant,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        );
                      }),
                      if (index < statsBySeasonList.length - 1)
                        const Divider(height: 24.0),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void populateStatsBySeason(List<ManagerTournamentStat> managerTournamentStats,
      Map<String, List<Map<String, dynamic>>> statsBySeason) {
    for (final stat in managerTournamentStats) {
      String? season = stat.season.value?.season;
      if (season != null && statsBySeason.containsKey(season)) {
        statsBySeason[season]!.add({
          'tournamentName': stat.tournament.value?.name ?? '',
          'finalPosition': stat.finalPosition,
          'isWinner': stat.isWinner
        });
      } else {
        if (season != null) {
          statsBySeason[season] = [];
          statsBySeason[season]!.add({
            'tournamentName': stat.tournament.value?.name ?? '',
            'finalPosition': stat.finalPosition,
            'isWinner': stat.isWinner
          });
        }
      }
    }
  }
}
