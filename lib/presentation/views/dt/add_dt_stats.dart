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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddDtStats extends StatelessWidget {
  final String managerId;
  const AddDtStats({super.key, required this.managerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agrega estadísticas'),
      ),
      body: _ManagerStatsForm(
        managerId: managerId,
      ),
    );
  }
}

class _ManagerStatsForm extends ConsumerStatefulWidget {
  final String managerId;
  const _ManagerStatsForm({required this.managerId});

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

  List<Tournament> getAvailableTournaments(List<Tournament> allTournaments, int? currentTournamentId) {
    final selectedTournamentIds = tournamentStats
        .map((stat) => stat['tournamentId'] as int?)
        .where((id) => id != null && id != currentTournamentId)
        .toSet();
    
    return allTournaments
        .where((tournament) => !selectedTournamentIds.contains(tournament.id))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    ref.read(managersProvider.notifier).getManager();
    ref.read(tournamentsProvider.notifier).loadNextPage();
    ref.read(seasonsProvider.notifier).getSeasons();
    ref.read(teamsProvider.notifier).loadNextPage();
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
    if (_formKey.currentState!.validate()) {
      manager = ref.read(managersProvider);
      team = await ref.read(teamsProvider.notifier).getTeam(selectedTeamID!);
      if (selectedSeasonID != null) {
        season = await ref
            .read(seasonsProvider.notifier)
            .getSeason(selectedSeasonID!);
      }

      if (season != null) {
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
        if (team != null) {
          managerStat.team.value = team;
        }
        if (selectedSeasonID != null && selectedTeamID != null) {
          final alreadySavedManagerStat = await ref
              .read(managerStatsProvider.notifier)
              .getManagerStatByDoubleKey(selectedSeasonID!, selectedTeamID!);
          if (alreadySavedManagerStat != null) {
            showDefaultDialog(
                // ignore: use_build_context_synchronously
                context,
                'Parece que ya guardaste una estadística con estos datos,¿Deseas actualizarla?',
                'Si, actualizar',
                'No, cambiar datos', () {
              context.pop();
            }, () {
              updateStats(managerStat, alreadySavedManagerStat.id);
              context.pop();
              _formKey.currentState!.reset();
            });
          } else {
            // Save manager stats
            saveStats(managerStat);
          }
        }

        // Save tournament stats
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

            saveTournamentStats(managerTournamentStat);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedSeasons = ref.watch(seasonsProvider).values.toList();
    final savedTournaments = ref.watch(tournamentsProvider).values.toList();
    final savedTeams = ref.watch(teamsProvider).values.toList();

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
                                items: getAvailableTournaments(savedTournaments, stat['tournamentId'])
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'La posición es requerida';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            updateTournamentStat(index, 'finalPosition', value);
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
    );
  }
}
