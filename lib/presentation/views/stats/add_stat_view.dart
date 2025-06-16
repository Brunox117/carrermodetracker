import 'package:carrermodetracker/config/helpers/show_default_dialog.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/seasons/seasons_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/shared/custom_dropdown_button.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_number_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';
import 'package:drops/drops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddStatView extends StatelessWidget {
  final String? teamId;
  final String? seasonId;
  final String? playerId;
  final String? tournamentId;
  final String? pastTeamStat;
  const AddStatView(
      {super.key,
      required this.teamId,
      this.seasonId,
      this.playerId,
      this.pastTeamStat,
      this.tournamentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _StatsForm(
          teamID: teamId,
          seasonId: seasonId,
          tournamentId: tournamentId,
          pastTeamStat: pastTeamStat,
          playerId: playerId),
    );
  }
}

class _StatsForm extends ConsumerStatefulWidget {
  final String? teamID;
  final String? seasonId;
  final String? playerId;
  final String? tournamentId;
  final String? pastTeamStat;
  const _StatsForm(
      {this.seasonId,
      this.playerId,
      this.pastTeamStat,
      this.tournamentId,
      required this.teamID});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __StatsFormState();
}

class __StatsFormState extends ConsumerState<_StatsForm> {
  final _formKey = GlobalKey<FormState>();
  int goals = 0;
  int assists = 0;
  int playedMatches = 0;
  double avgScore = 0;
  int cleanSheets = 0;
  int redCards = 0;
  int yellowCards = 0;
  int? selectedSeasonID;
  int? selectedPlayerID;
  int? selectedTournamentID;
  int? selectedTeamID;
  Season? season;
  Tournament? tournament;
  Team? team;
  Player? player;
  // Add controllers
  late TextEditingController goalsController;
  late TextEditingController assistsController;
  late TextEditingController playedMatchesController;
  late TextEditingController avgScoreController;
  late TextEditingController cleanSheetsController;
  late TextEditingController redCardsController;
  late TextEditingController yellowCardsController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    goalsController = TextEditingController(text: goals.toString());
    assistsController = TextEditingController(text: assists.toString());
    playedMatchesController =
        TextEditingController(text: playedMatches.toString());
    avgScoreController = TextEditingController(text: avgScore.toString());
    cleanSheetsController = TextEditingController(text: cleanSheets.toString());
    redCardsController = TextEditingController(text: redCards.toString());
    yellowCardsController = TextEditingController(text: yellowCards.toString());
    if (widget.teamID != null && widget.teamID != '') {
      ref
          .read(playersProvider.notifier)
          .getPlayersByTeam(int.parse(widget.teamID!));
    }
    ref.read(tournamentsProvider.notifier).loadNextPage();
    ref.read(seasonsProvider.notifier).getSeasons();
    ref.read(teamsProvider.notifier).loadNextPage();
    if (widget.seasonId != null &&
        widget.playerId != null &&
        widget.pastTeamStat != null &&
        widget.tournamentId != null) {
      populateStats();
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    goalsController.dispose();
    assistsController.dispose();
    playedMatchesController.dispose();
    avgScoreController.dispose();
    cleanSheetsController.dispose();
    redCardsController.dispose();
    yellowCardsController.dispose();
    super.dispose();
  }

  void cleanForm() {
    goals = 0;
    assists = 0;
    playedMatches = 0;
    avgScore = 0;
    cleanSheets = 0;
    redCards = 0;
    yellowCards = 0;
    selectedSeasonID = null;
    selectedPlayerID = null;
    selectedTournamentID = null;
    selectedTeamID = null;
    isEditing = false;

    // Reset controllers
    goalsController.text = '0';
    assistsController.text = '0';
    playedMatchesController.text = '0';
    avgScoreController.text = '0';
    cleanSheetsController.text = '0';
    redCardsController.text = '0';
    yellowCardsController.text = '0';
  }

  void populateStats() async {
    selectedPlayerID = int.parse(widget.playerId!);
    selectedTournamentID = int.parse(widget.tournamentId!);
    selectedSeasonID = int.parse(widget.seasonId!);
    selectedTeamID = int.parse(widget.pastTeamStat!);
    final Stats? statFromBackend = await ref
        .read(statsProvider.notifier)
        .getStatByTripleKey(
            selectedPlayerID!, selectedTournamentID!, selectedSeasonID!);

    if (statFromBackend != null) {
      setState(() {
        goals = statFromBackend.goals;
        assists = statFromBackend.assists;
        playedMatches = statFromBackend.playedMatches;
        avgScore = statFromBackend.avgScore;
        cleanSheets = statFromBackend.cleanSheets;
        redCards = statFromBackend.redCards;
        yellowCards = statFromBackend.yellowCards;
        isEditing = true;

        // Update controllers
        goalsController.text = goals.toString();
        assistsController.text = assists.toString();
        playedMatchesController.text = playedMatches.toString();
        avgScoreController.text = avgScore.toString();
        cleanSheetsController.text = cleanSheets.toString();
        redCardsController.text = redCards.toString();
        yellowCardsController.text = yellowCards.toString();
      });
    }
  }

  void saveStat(Stats stat) {
    ref.read(statsProvider.notifier).saveStats(stat);
  }

  void updateStat(Stats stat, int id) {
    ref.read(statsProvider.notifier).updateStats(id, stat);
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (selectedSeasonID != null) {
        season = await ref
            .read(seasonsProvider.notifier)
            .getSeason(selectedSeasonID!);
      }
      if (selectedPlayerID != null) {
        final playersMap = ref.read(playersProvider);
        player = playersMap[selectedPlayerID];
      }
      if (selectedTournamentID != null) {
        tournament = await ref
            .read(tournamentsProvider.notifier)
            .getTournament(selectedTournamentID!);
      }
      if (selectedTeamID != null) {
        team = await ref.read(teamsProvider.notifier).getTeam(selectedTeamID!);
      }
      if (season != null &&
          tournament != null &&
          player != null &&
          team != null) {
        final Stats? alreadeSavedStat = await ref
            .read(statsProvider.notifier)
            .getStatByQuadrupleKey(
                player!.id, tournament!.id, season!.id, team!.id);
        final Stats statToSave = Stats(
            assists: assists,
            goals: goals,
            playedMatches: playedMatches,
            avgScore: avgScore,
            cleanSheets: cleanSheets,
            redCards: redCards,
            yellowCards: yellowCards);
        statToSave.player.value = player;
        statToSave.tournament.value = tournament;
        statToSave.season.value = season;
        statToSave.team.value = team;
        if (alreadeSavedStat == null) {
          _formKey.currentState!.reset();
          saveStat(statToSave);
          cleanForm();
        } else {
          statToSave.id = alreadeSavedStat.id;
          if (isEditing) {
            updateStat(statToSave, alreadeSavedStat.id);
            Drops.show(
              shape: DropShape.squared,
              // ignore: use_build_context_synchronously
              context,
              title: "Estadística registrada correctamente!",
            );
            _formKey.currentState!.reset();
            cleanForm();
            return;
          }
          showDefaultDialog(
              // ignore: use_build_context_synchronously
              context,
              'Parece que ya guardaste una estadística con estos datos,¿Deseas actualizarla?',
              'Si, actualizar',
              'No, cambiar datos', () {
            context.pop();
          }, () {
            context.pop();
            updateStat(statToSave, alreadeSavedStat.id);
            Drops.show(
              shape: DropShape.squared,
              // ignore: use_build_context_synchronously
              context,
              title: "Estadística actualizada correctamente!",
            );
            _formKey.currentState!.reset();
            cleanForm();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedSeasons = ref.watch(seasonsProvider).values.toList();
    final savedPlayers = ref.watch(playersProvider).values.toList();
    final savedTournaments = ref.watch(tournamentsProvider).values.toList();
    final savedTeams = ref.watch(teamsProvider).values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            (!isEditing) ? 'Registra estadísticas' : 'Editando estadísticas'),
      ),
      body: Padding(
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
                      const SizedBox(height: 10),
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
                      CustomDropdownButtonFormField<int>(
                        labelText: "Selecciona equipo:",
                        hintText: "Equipo...",
                        value: selectedTeamID,
                        items: savedTeams.map((Team team) {
                          return DropdownMenuItem<int>(
                            value: team.id,
                            child: Text(team.name),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedTeamID = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Column(
                      children: [
                        CustomNumberFormField(
                          key: const ValueKey('goals_field'),
                          controller: goalsController,
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
                          key: const ValueKey('assists_field'),
                          controller: assistsController,
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
                          key: const ValueKey('played_matches_field'),
                          controller: playedMatchesController,
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
                        ExpansionTile(
                          title: const Text("Información adicional"),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          shape: const Border(),
                          collapsedShape: const Border(),
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                CustomNumberFormField(
                                  key: const ValueKey('clean_sheets_field'),
                                  controller: cleanSheetsController,
                                  isBottomField: true,
                                  isTopField: true,
                                  label: 'Porterías imbatidas',
                                  hint: '',
                                  onChanged: (value) {
                                    final number = int.tryParse(value);
                                    if (number != null) {
                                      cleanSheets = number;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CustomNumberFormField(
                                  key: const ValueKey('yellow_cards_field'),
                                  controller: yellowCardsController,
                                  isBottomField: true,
                                  isTopField: true,
                                  label: 'Tarjetas Amarillas',
                                  hint: '',
                                  onChanged: (value) {
                                    final number = int.tryParse(value);
                                    if (number != null) {
                                      yellowCards = number;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CustomNumberFormField(
                                  key: const ValueKey('red_cards_field'),
                                  controller: redCardsController,
                                  isBottomField: true,
                                  isTopField: true,
                                  label: 'Tarjetas rojas',
                                  hint: '',
                                  onChanged: (value) {
                                    final number = int.tryParse(value);
                                    if (number != null) {
                                      redCards = number;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CustomNumberFormField(
                                  key: const ValueKey('avg_score_field'),
                                  controller: avgScoreController,
                                  isBottomField: true,
                                  isTopField: true,
                                  label: 'Calificación',
                                  hint: '',
                                  onChanged: (value) {
                                    final number = double.tryParse(value);
                                    if (number != null) {
                                      avgScore = number;
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SaveFormButton(
                    submitForm: submitForm,
                    // onSaveTextAlert: 'Estadística guardada correctamente!',
                  )
                ],
              ),
            )),
      ),
    );
  }
}
