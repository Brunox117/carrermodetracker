import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/seasons/seasons_provider.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/player_info_row.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/table_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamOverview extends ConsumerStatefulWidget {
  final String id;
  const TeamOverview({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TeamOverviewState();
}

class _TeamOverviewState extends ConsumerState<TeamOverview> {
  @override
  void initState() {
    super.initState();
    ref.read(seasonsProvider.notifier).getSeasons();
    ref.read(tournamentsProvider.notifier).loadNextPage();
    ref.read(playersProvider.notifier).getPlayersByTeam(int.parse(widget.id));
  }

  List<Player> players = [];
  List<int> selectedSeasonIDs = [];
  List<int> selectedTournamentIDs = [];
  List<Season> savedSeasons = [];
  List<Tournament> savedTournaments = [];

  @override
  Widget build(BuildContext context) {
    savedSeasons = ref.watch(seasonsProvider).values.toList();
    savedTournaments = ref.watch(tournamentsProvider).values.toList();
    players = ref
        .watch(playersProvider)
        .values
        .where((player) =>
            player.team.value != null &&
            player.team.value!.id == int.parse(widget.id))
        .toList();
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Filtra por temporada:", style: textStyles.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: savedSeasons.map((Season season) {
              final isSelected = selectedSeasonIDs.contains(season.id);
              return FilterChip(
                label: Text(season.season.toString()),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedSeasonIDs.add(season.id);
                    } else {
                      selectedSeasonIDs.remove(season.id);
                    }
                  });
                },
                selectedColor: colors.primaryContainer,
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Text("Filtra por torneo:", style: textStyles.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: savedTournaments.map((Tournament tournament) {
              final isSelected = selectedTournamentIDs.contains(tournament.id);
              return FilterChip(
                label: Text(tournament.name),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedTournamentIDs.add(tournament.id);
                    } else {
                      selectedTournamentIDs.remove(tournament.id);
                    }
                  });
                },
                selectedColor: colors.primaryContainer,
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.1), // Posición
              1: FlexColumnWidth(2), // Nombre
              2: FlexColumnWidth(.9), // PJ
              3: FlexColumnWidth(.9), // Goles
              4: FlexColumnWidth(.9), // As.
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                  decoration: BoxDecoration(
                      color: colors.secondary.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  children: const [
                    TableCell(
                        child: TableText(
                      'Posición',
                      isHeader: true,
                    )),
                    TableCell(
                        child: TableText(
                      'Nombre',
                      isHeader: true,
                    )),
                    TableCell(
                        child: TableText(
                      'PJ',
                      isHeader: true,
                    )),
                    TableCell(
                        child: TableText(
                      'Goles',
                      isHeader: true,
                    )),
                    TableCell(
                        child: TableText(
                      'As.',
                      isHeader: true,
                    )),
                  ]),
              ...players.map((player) => buildTableRow(
                  context, player, selectedSeasonIDs, selectedTournamentIDs)),
            ],
          ),
        ],
      ),
    );
  }
}
