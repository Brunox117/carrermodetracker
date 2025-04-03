import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:flutter/material.dart';

class TeamOverviewFilter extends StatelessWidget {
  final List<Season> availableSeasons;
  final List<Tournament> availableTournaments;
  final List<int> selectedSeasonIDs;
  final List<int> selectedTournamentIDs;
  final ValueChanged<int> onSeasonSelected;
  final ValueChanged<int> onTournamentSelected;
  final VoidCallback onClearSeasonFilters;
  final VoidCallback onClearTournamentFilters;

  const TeamOverviewFilter({
    super.key,
    required this.availableSeasons,
    required this.availableTournaments,
    required this.selectedSeasonIDs,
    required this.selectedTournamentIDs,
    required this.onSeasonSelected,
    required this.onTournamentSelected,
    required this.onClearSeasonFilters,
    required this.onClearTournamentFilters,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filtrar por Temporada", style: textStyles.titleMedium),
                  (selectedSeasonIDs.isNotEmpty)
                      ? IconButton(
                          onPressed: onClearSeasonFilters,
                          icon: const Icon(Icons.delete))
                      : const SizedBox(),
                ]),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            shape: const Border(),
            collapsedShape: const Border(),
            children: [
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: availableSeasons.map((Season season) {
                  final isSelected = selectedSeasonIDs.contains(season.id);
                  return FilterChip(
                    label: Text(season.season.toString()),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      onSeasonSelected(season.id); // Notify parent via callback
                    },
                    selectedColor: colors.primaryContainer,
                    showCheckmark: false,
                  );
                }).toList(),
              ),
            ]),
        const SizedBox(height: 10),
        ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Filtrar por Torneo", style: textStyles.titleMedium),
                (selectedTournamentIDs.isNotEmpty)
                    ? IconButton(
                        onPressed: onClearTournamentFilters,
                        icon: const Icon(Icons.delete))
                    : const SizedBox(),
              ],
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            shape: const Border(),
            collapsedShape: const Border(),
            children: [
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: availableTournaments.map((Tournament tournament) {
                  final isSelected =
                      selectedTournamentIDs.contains(tournament.id);
                  return FilterChip(
                    label: Text(tournament.name),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      onTournamentSelected(
                          tournament.id); // Notify parent via callback
                    },
                    selectedColor: colors.primaryContainer,
                    showCheckmark: false,
                  );
                }).toList(),
              ),
            ]),
      ],
    );
  }
}
