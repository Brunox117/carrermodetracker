import 'package:carrermodetracker/config/helpers/show_default_dialog.dart';
import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/presentation/providers/manager/managers_provider.dart';
import 'package:carrermodetracker/presentation/providers/seasons/seasons_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_tournament_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_number_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';
import 'package:carrermodetracker/presentation/widgets/shared/custom_dropdown_button.dart';
import 'package:drops/drops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddDtStats extends StatelessWidget {
  final String managerId;
  final String? seasonId;
  final String? teamId;
  const AddDtStats(
      {super.key, required this.managerId, this.seasonId, this.teamId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ManagerStatsForm(
        managerId: managerId,
        seasonId: seasonId,
        teamId: teamId,
      ),
    );
  }
}

class _ManagerStatsForm extends ConsumerStatefulWidget {
  final String managerId;
  final String? seasonId;
  final String? teamId;
  const _ManagerStatsForm(
      {required this.managerId, this.seasonId, this.teamId});

  @override
  ConsumerState<_ManagerStatsForm> createState() => _ManagerStatsFormState();
}

class _ManagerStatsFormState extends ConsumerState<_ManagerStatsForm> {
  final _formKey = GlobalKey<FormState>();
  int playedMatches = 0;
  int wins = 0;
  int loses = 0;
  int draws = 0;
  int goalsScored = 0;
  int goalsConceded = 0;
  int? selectedSeasonID;
  int? selectedTeamID;
  Season? season;
  Manager? manager;
  Team? team;
  List<Map<String, dynamic>> tournamentStats = [];
  bool isEditing = false;

  // Add controllers
  late TextEditingController playedMatchesController;
  late TextEditingController winsController;
  late TextEditingController losesController;
  late TextEditingController drawsController;
  late TextEditingController goalsScoredController;
  late TextEditingController goalsConcededController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    playedMatchesController =
        TextEditingController(text: playedMatches.toString());
    winsController = TextEditingController(text: wins.toString());
    losesController = TextEditingController(text: loses.toString());
    drawsController = TextEditingController(text: draws.toString());
    goalsScoredController = TextEditingController(text: goalsScored.toString());
    goalsConcededController =
        TextEditingController(text: goalsConceded.toString());

    ref.read(managersProvider.notifier).getManager();
    ref.read(tournamentsProvider.notifier).loadNextPage();
    ref.read(seasonsProvider.notifier).getSeasons();
    ref.read(teamsProvider.notifier).loadNextPage();
    if (widget.seasonId != null && widget.teamId != null) {
      populateStats();
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    playedMatchesController.dispose();
    winsController.dispose();
    losesController.dispose();
    drawsController.dispose();
    goalsScoredController.dispose();
    goalsConcededController.dispose();
    super.dispose();
  }

  void cleanForm() {
    playedMatches = 0;
    wins = 0;
    loses = 0;
    draws = 0;
    goalsScored = 0;
    goalsConceded = 0;
    selectedSeasonID = null;
    selectedTeamID = null;
    season = null;
    team = null;

    // Dispose and clear tournament controllers
    for (var stat in tournamentStats) {
      stat['finalPositionController'].dispose();
    }
    tournamentStats = [];
    isEditing = false;

    // Reset controllers
    playedMatchesController.text = '0';
    winsController.text = '0';
    losesController.text = '0';
    drawsController.text = '0';
    goalsScoredController.text = '0';
    goalsConcededController.text = '0';
  }

  List<Tournament> getAvailableTournaments(
      List<Tournament> allTournaments, int? currentTournamentId) {
    final selectedTournamentIds = tournamentStats
        .map((stat) => stat['tournamentId'] as int?)
        .where((id) => id != null && id != currentTournamentId)
        .toSet();

    return allTournaments
        .where((tournament) => !selectedTournamentIds.contains(tournament.id))
        .toList();
  }

  void populateStats() async {
    isEditing = true;
    selectedSeasonID = int.parse(widget.seasonId!);
    selectedTeamID = int.parse(widget.teamId!);
    Managerstat? mngStatFromBackend = await ref
        .read(managerStatsProvider.notifier)
        .getManagerStatByDoubleKey(
            int.parse(widget.seasonId!), int.parse(widget.teamId!));
    List<ManagerTournamentStat> mgnTournamentStatsFromBackend = await ref
        .read(managerTournamentStatsProvider.notifier)
        .getManagerTournamentStatByDoubleKey(
            int.parse(widget.seasonId!), int.parse(widget.teamId!));

    if (mngStatFromBackend != null) {
      setState(() {
        playedMatches = mngStatFromBackend.playedMatches;
        wins = mngStatFromBackend.wins;
        loses = mngStatFromBackend.loses;
        draws = mngStatFromBackend.draws;
        goalsScored = mngStatFromBackend.goalsScored;
        goalsConceded = mngStatFromBackend.goalsConceded;

        // Update controllers
        playedMatchesController.text = playedMatches.toString();
        winsController.text = wins.toString();
        losesController.text = loses.toString();
        drawsController.text = draws.toString();
        goalsScoredController.text = goalsScored.toString();
        goalsConcededController.text = goalsConceded.toString();
      });
    }

    if (mgnTournamentStatsFromBackend.isNotEmpty) {
      setState(() {
        tournamentStats = mgnTournamentStatsFromBackend.map((stat) {
          return {
            'tournamentId': stat.tournament.value?.id,
            'finalPosition': stat.finalPosition,
            'isWinner': stat.isWinner,
          };
        }).toList();
      });
    }
  }

  void addTournamentStat() {
    setState(() {
      tournamentStats.add({
        'tournamentId': null,
        'finalPosition': '',
        'isWinner': false,
      });
    });
  }

  void removeTournamentStat(int index) {
    setState(() {
      tournamentStats.removeAt(index);
    });
  }

  void updateTournamentStat(int index, String field, dynamic value) {
    setState(() {
      tournamentStats[index][field] = value;
    });
  }

  void saveStats(Managerstat managerStat) {
    ref.read(managerStatsProvider.notifier).addManagerStat(managerStat);
  }

  void saveTournamentStats(ManagerTournamentStat managerTournamentStat) {
    ref
        .read(managerTournamentStatsProvider.notifier)
        .addManagerTournamentStat(managerTournamentStat);
  }

  void updateStats(Managerstat managerStat, int id) {
    ref.read(managerStatsProvider.notifier).updateManagerStat(id, managerStat);
  }

  void updateTournamentStats(
      int id, ManagerTournamentStat managerTournamentStat) {
    ref
        .read(managerTournamentStatsProvider.notifier)
        .updateManagerTournamentStat(id, managerTournamentStat);
  }

  void submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedSeasonID == null || selectedTeamID == null) {
      showDefaultDialog(
        context,
        'Por favor selecciona una temporada y un equipo',
        'Entendido',
        'Cancelar',
        () => context.pop(),
        () => context.pop(),
      );
      return;
    }
    manager = ref.read(managersProvider);
    team = await ref.read(teamsProvider.notifier).getTeam(selectedTeamID!);
    season =
        await ref.read(seasonsProvider.notifier).getSeason(selectedSeasonID!);

    if (season == null) return;
    // Check if stats already exist
    final alreadySavedManagerStat = await ref
        .read(managerStatsProvider.notifier)
        .getManagerStatByDoubleKey(selectedSeasonID!, selectedTeamID!);

    if (alreadySavedManagerStat != null) {
      if (isEditing) {
        await _saveOrUpdateStats(alreadySavedManagerStat.id);
        return;
      }
      showDefaultDialog(
        // ignore: use_build_context_synchronously
        context,
        'Ya existe una estadística registrada para este equipo en esta temporada. ¿Deseas actualizarla?',
        'Sí, actualizar',
        'No, cancelar',
        () {
          context.pop();
        },
        () async {
          await _saveOrUpdateStats(alreadySavedManagerStat.id);
          // ignore: use_build_context_synchronously
          context.pop();
        },
      );
      return;
    }

    await _saveOrUpdateStats();
  }

  Future<void> _saveOrUpdateStats([int? existingStatId]) async {
    final managerStat = Managerstat(
      playedMatches: playedMatches,
      wins: wins,
      loses: loses,
      draws: draws,
      goalsScored: goalsScored,
      goalsConceded: goalsConceded,
    );

    managerStat.season.value = season;
    managerStat.manager.value = manager;
    managerStat.team.value = team;

    if (existingStatId != null) {
      updateStats(managerStat, existingStatId);
    } else {
      saveStats(managerStat);
    }

    // Save tournament stats
    final alreadySavedManagerTournamentStats = await ref
        .read(managerTournamentStatsProvider.notifier)
        .getManagerTournamentStatByDoubleKey(
            selectedSeasonID!, selectedTeamID!);

    for (var tournamentStat in tournamentStats) {
      if (tournamentStat['tournamentId'] != null) {
        final tournament = await ref
            .read(tournamentsProvider.notifier)
            .getTournament(tournamentStat['tournamentId']);

        final managerTournamentStat = ManagerTournamentStat(
          finalPosition: tournamentStat['finalPosition'],
          isWinner: tournamentStat['isWinner'],
        );

        managerTournamentStat.tournament.value = tournament;
        managerTournamentStat.season.value = season;
        managerTournamentStat.manager.value = manager;
        managerTournamentStat.team.value = team;

        final existingTournamentStat = alreadySavedManagerTournamentStats
            .where((stat) =>
                stat.tournament.value?.id == tournamentStat['tournamentId'])
            .firstOrNull;

        if (existingTournamentStat != null) {
          updateTournamentStats(
              existingTournamentStat.id, managerTournamentStat);
        } else {
          saveTournamentStats(managerTournamentStat);
        }
      }
    }
    Drops.show(
      shape: DropShape.squared,
      // ignore: use_build_context_synchronously
      context,
      title: "Guardado exitoso!",
    );
    _formKey.currentState!.reset();
    cleanForm();
  }

  @override
  Widget build(BuildContext context) {
    final savedSeasons = ref.watch(seasonsProvider).values.toList();
    final savedTournaments = ref.watch(tournamentsProvider).values.toList();
    final savedTeams = ref.watch(teamsProvider).values.toList();

    return Scaffold(
      appBar: AppBar(
        title:
            Text((isEditing) ? 'Editando estadísticas' : 'Agrega estadísticas'),
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
                      labelText: "Selecciona la temporada:",
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
                    CustomDropdownButtonFormField<int>(
                      labelText: "Selecciona el equipo:",
                      hintText: "Equipo...",
                      value: selectedTeamID,
                      items: savedTeams.map((Team team) {
                        return DropdownMenuItem<int>(
                          value: team.id,
                          child: Text(team.name.toString()),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedTeamID = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Estadísticas globales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomNumberFormField(
                      key: const ValueKey('played_matches_field'),
                      controller: playedMatchesController,
                      isBottomField: true,
                      isTopField: true,
                      label: 'Partidos jugados',
                      hint: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El campo es requerido';
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
                    const SizedBox(height: 12),
                    CustomNumberFormField(
                      key: const ValueKey('wins_field'),
                      controller: winsController,
                      isBottomField: true,
                      isTopField: true,
                      label: 'Victorias',
                      hint: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El campo es requerido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          wins = number;
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomNumberFormField(
                      key: const ValueKey('draws_field'),
                      controller: drawsController,
                      isBottomField: true,
                      isTopField: true,
                      label: 'Empates',
                      hint: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El campo es requerido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          draws = number;
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomNumberFormField(
                      key: const ValueKey('loses_field'),
                      controller: losesController,
                      isBottomField: true,
                      isTopField: true,
                      label: 'Derrotas',
                      hint: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El campo es requerido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          loses = number;
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomNumberFormField(
                      key: const ValueKey('goals_scored_field'),
                      controller: goalsScoredController,
                      isBottomField: true,
                      isTopField: true,
                      label: 'Goles anotados',
                      hint: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El campo es requerido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          goalsScored = number;
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomNumberFormField(
                      key: const ValueKey('goals_conceded_field'),
                      controller: goalsConcededController,
                      isBottomField: true,
                      isTopField: true,
                      label: 'Goles recibidos',
                      hint: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El campo es requerido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          goalsConceded = number;
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Torneos disputados',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...tournamentStats.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stat = entry.value;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdownButtonFormField<int>(
                                  labelText: "Torneo",
                                  hintText: "Elige un torneo...",
                                  value: stat['tournamentId'],
                                  items: getAvailableTournaments(
                                          savedTournaments,
                                          stat['tournamentId'])
                                      .map((Tournament tournament) {
                                    return DropdownMenuItem<int>(
                                      value: tournament.id,
                                      child: Text(tournament.name),
                                    );
                                  }).toList(),
                                  onChanged: (int? newValue) {
                                    updateTournamentStat(
                                        index, 'tournamentId', newValue);
                                  },
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => removeTournamentStat(index),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomFormField(
                            isBottomField: true,
                            isTopField: true,
                            label: 'Posición final',
                            hint: '',
                            initialValue: stat['finalPosition'],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'La posición es requerida';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              updateTournamentStat(
                                  index, 'finalPosition', value);
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(
                                value: stat['isWinner'],
                                onChanged: (bool? value) {
                                  updateTournamentStat(
                                      index, 'isWinner', value ?? false);
                                },
                              ),
                              const Text('Campeón'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: addTournamentStat,
                  icon: const Icon(Icons.add),
                  label: const Text('Agrega un torneo'),
                ),
                const SizedBox(height: 20),
                SaveFormButton(
                  submitForm: submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
