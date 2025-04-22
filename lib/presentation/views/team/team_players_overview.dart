import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/seasons/seasons_provider.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/team_overview/team_overview_filter.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/player_info_row.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/table_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamPlayersOverview extends ConsumerStatefulWidget {
  final String id;
  const TeamPlayersOverview({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TeamPlayersOverviewState();
}

class _TeamPlayersOverviewState extends ConsumerState<TeamPlayersOverview> {
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

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TeamOverviewFilter(
              availableSeasons: savedSeasons,
              availableTournaments: savedTournaments,
              selectedSeasonIDs: selectedSeasonIDs,
              selectedTournamentIDs: selectedTournamentIDs,
              onSeasonSelected: (seasonId) {
                setState(() {
                  if (selectedSeasonIDs.contains(seasonId)) {
                    selectedSeasonIDs.remove(seasonId);
                  } else {
                    selectedSeasonIDs.add(seasonId);
                  }
                });
              },
              onTournamentSelected: (tournamentId) {
                setState(() {
                  if (selectedTournamentIDs.contains(tournamentId)) {
                    selectedTournamentIDs.remove(tournamentId);
                  } else {
                    selectedTournamentIDs.add(tournamentId);
                  }
                });
              },
              onClearSeasonFilters: () {
                setState(() {
                  selectedSeasonIDs.clear();
                });
              },
              onClearTournamentFilters: () {
                setState(() {
                  selectedTournamentIDs.clear();
                });
              },
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
                        color: colors.secondary.withValues(alpha: 0.2),
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
                        'P',
                        isHeader: true,
                      )),
                      TableCell(
                          child: TableText(
                        'G',
                        isHeader: true,
                      )),
                      TableCell(
                          child: TableText(
                        'A',
                        isHeader: true,
                      )),
                    ]),
                ...players.map((player) => buildTableRow(
                    context, player, selectedSeasonIDs, selectedTournamentIDs)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
