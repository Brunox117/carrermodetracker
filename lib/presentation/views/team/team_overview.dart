import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/seasons/seasons_provider.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/shared/custom_dropdown_button.dart';
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
  int? selectedSeasonID;
  int? selectedTournamentID;
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
      child: Column(
        children: [
          CustomDropdownButtonFormField<int>(
            labelText: "Filtra por temporada:",
            hintText: "Temporada...",
            value: selectedSeasonID,
            items: savedSeasons.map((Season season) {
              return DropdownMenuItem<int>(
                value: season.id,
                child: Text(season.season.toString()),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                selectedSeasonID = newValue;
              });
            },
          ),
          (selectedSeasonID != null)
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      selectedSeasonID = null;
                    });
                  },
                  child: const Text("Borra filtro"))
              : const SizedBox(),
          const SizedBox(
            height: 20,
          ),
          CustomDropdownButtonFormField<int>(
            labelText: "Filtra por torneo:",
            hintText: "Torneo...",
            value: selectedTournamentID,
            items: savedTournaments.map((Tournament tournament) {
              return DropdownMenuItem<int>(
                value: tournament.id,
                child: Text(tournament.name),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                selectedTournamentID = newValue;
              });
            },
          ),
          (selectedTournamentID != null)
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTournamentID = null;
                    });
                  },
                  child: const Text("Borra filtro"))
              : const SizedBox(),
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
                    // TableCell(child: Center(child: Text('PI'))),
                  ]),
              ...players.map((player) => buildTableRow(
                  context, player, selectedSeasonID, selectedTournamentID)),
            ],
          ),
        ],
      ),
    );
  }
}
