import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/seasons/seasons_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/shared/custom_dropdown_button.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_number_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddStatView extends StatelessWidget {
  final String id;
  const AddStatView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registra estadísticas'),
      ),
      body: _StatsForm(
        teamID: id,
      ),
    );
  }
}

class _StatsForm extends ConsumerStatefulWidget {
  final String teamID;
  const _StatsForm({required this.teamID});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __StatsFormState();
}

class __StatsFormState extends ConsumerState<_StatsForm> {
  final _formKey = GlobalKey<FormState>();
  int goals = 0;
  int assists = 0;
  int playedMatches = 0;
  int? selectedSeasonID;
  int? selectedPlayerID;
  int? selectedTournamentID;
  Season? season;
  Tournament? tournament;
  Player? player;

  @override
  void initState() {
    super.initState();
    ref
        .read(playersProvider.notifier)
        .getPlayersByTeam(int.parse(widget.teamID));
    ref.read(tournamentsProvider.notifier).loadNextPage();
    ref.read(seasonsProvider.notifier).getSeasons();
  }

  void submitStat(Stats stat) {
    ref.read(statsProvider.notifier).saveStats(stat);
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (selectedSeasonID != null) {
        season = await ref
            .read(seasonsProvider.notifier)
            .getSeason(selectedSeasonID!);
      }
      if (selectedPlayerID != null) {
        player = await ref
            .read(playersProvider.notifier)
            .getPlayer(selectedPlayerID!);
      }
      if (selectedTournamentID != null) {
        tournament = await ref
            .read(tournamentsProvider.notifier)
            .getTournament(selectedTournamentID!);
      }
      if (season != null && tournament != null && player != null) {
        final Stats stats =
            Stats(assists: assists, goals: goals, playedMatches: playedMatches);
        stats.player.value = player;
        stats.tournament.value = tournament;
        stats.season.value = season;
        _formKey.currentState!.reset();
        submitStat(stats);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedSeasons = ref.watch(seasonsProvider).values.toList();
    final savedPlayers = ref.watch(playersProvider).values.toList();
    final savedTournaments = ref.watch(tournamentsProvider).values.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropdownButtonFormField<int>(
                      labelText: "Selecciona Temporada:",
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
                    const SizedBox(height: 20),
                    CustomDropdownButtonFormField<int>(
                      labelText: "Selecciona Jugador:",
                      hintText: "Jugador...",
                      value: selectedPlayerID,
                      items: savedPlayers.map((Player player) {
                        return DropdownMenuItem<int>(
                          value: player.id,
                          child: Text(player.name),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedPlayerID = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomDropdownButtonFormField<int>(
                      labelText: "Selecciona Torneo:",
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    children: [
                      CustomNumberFormField(
                        isBottomField: true,
                        isTopField: true,
                        label: 'Goles',
                        hint: '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          final number = int.tryParse(value);
                          if (number != null) {
                            goals = number;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomNumberFormField(
                        isBottomField: true,
                        isTopField: true,
                        label: 'Asistencias',
                        hint: '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          final number = int.tryParse(value);
                          if (number != null) {
                            assists = number;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomNumberFormField(
                        isBottomField: true,
                        isTopField: true,
                        label: 'Partidos jugados',
                        hint: '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          final number = int.tryParse(value);
                          if (number != null) {
                            playedMatches = number;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SaveFormButton(submitForm: submitForm)
              ],
            ),
          )),
    );
  }
}
