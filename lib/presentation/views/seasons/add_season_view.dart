import 'package:carrermodetracker/config/helpers/show_default_dialog.dart';
import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/seasons/seasons_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_tournament_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';
import 'package:drops/drops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddSeasonView extends ConsumerStatefulWidget {
  const AddSeasonView({super.key});

  @override
  ConsumerState<AddSeasonView> createState() => _AddSeasonViewState();
}

class _AddSeasonViewState extends ConsumerState<AddSeasonView> {
  final _formKey = GlobalKey<FormState>();
  int? startYear;
  int? endYear;
  List<Season> savedSeasons = [];
  bool updatingSeason = false;
  int? updateSeasonId;

  void submitSeason(Season seasonTS) {
    ref.read(seasonsProvider.notifier).saveSeason(seasonTS);
  }

  void updateSeason(int id, Season seasonTU) {
    ref.read(seasonsProvider.notifier).updateSeason(id, seasonTU);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final seasonValue = '$startYear-$endYear';
      if (updatingSeason) {
        Season seasonToUpdate = Season(season: seasonValue);
        bool seasonExists = savedSeasons.any(
            (s) => s.season == seasonToUpdate.season && s.id != updateSeasonId);
        if (seasonExists) {
          repeatedSeasonDialog(
              'Ya tienes al menos una temporada con este nombre. ¿Estas seguro de que deseas guardar otra con el mismo nombre?',
              () {
            updateSeason(updateSeasonId!, seasonToUpdate);
            Drops.show(
              shape: DropShape.squared,
              context,
              title: "Estadística actualizada correctamente!",
            );
            _formKey.currentState!.reset();
            setState(() {
              updatingSeason = false;
              updateSeasonId = null;
              startYear = null;
              endYear = null;
            });
          });
        } else {
          updateSeason(updateSeasonId!, seasonToUpdate);
          Drops.show(
            shape: DropShape.squared,
            context,
            title: "Estadística actualizada correctamente!",
          );
          _formKey.currentState!.reset();
          setState(() {
            updatingSeason = false;
            updateSeasonId = null;
            startYear = null;
            endYear = null;
          });
        }
      } else {
        final Season seasonToSave = Season(season: seasonValue);
        bool seasonExists =
            savedSeasons.any((s) => s.season == seasonToSave.season);
        if (seasonExists) {
          repeatedSeasonDialog(
              'Ya tienes al menos una temporada con este nombre. ¿Estas seguro de que deseas guardar otra con el mismo nombre?',
              () {
            submitSeason(seasonToSave);
            Drops.show(
              shape: DropShape.squared,
              context,
              title: "Estadística guardada correctamente!",
            );
            _formKey.currentState!.reset();
            context.pop();
            setState(() {
              startYear = null;
              endYear = null;
            });
          });
        } else {
          submitSeason(seasonToSave);
          Drops.show(
            shape: DropShape.squared,
            context,
            title: "Estadística guardada correctamente!",
          );
          _formKey.currentState!.reset();
          setState(() {
            startYear = null;
            endYear = null;
          });
        }
      }
    }
  }

  Future<dynamic> repeatedSeasonDialog(
      String message, void Function()? onPressed) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("No, cambiar nombre"),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  void getSeasons() async {
    ref.read(seasonsProvider.notifier).getSeasons();
  }

  List<int> _getYearOptions() {
    final now = DateTime.now();
    final currentYear = now.year;
    return List.generate(25, (index) => currentYear - 1 + index);
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final currentYear = now.month > 6 ? now.year : now.year - 1;
    startYear = currentYear;
    endYear = currentYear + 1;
    getSeasons();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final seasonsMap = ref.watch(seasonsProvider);
    savedSeasons = seasonsMap.values.toList();
    final yearOptions = _getYearOptions();

    return Scaffold(
        appBar: AppBar(
          title: Text((updatingSeason)
              ? 'Editando una temporada'
              : 'Agrega una temporada'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    (updatingSeason)
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                updatingSeason = false;
                                updateSeasonId = null;
                                startYear = null;
                                endYear = null;
                              });
                            },
                            child: const Text('Cancelar edición'))
                        : SizedBox(
                            height: MediaQuery.of(context).size.width * 0.1),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: startYear,
                            dropdownColor:
                                Theme.of(context).colorScheme.surface,
                            menuMaxHeight: 300,
                            borderRadius: BorderRadius.circular(12),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            items: yearOptions
                                .map((year) => DropdownMenuItem(
                                      value: year,
                                      child: Text(year.toString()),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  startYear = value;
                                  final lastYear = yearOptions.last;
                                  endYear = value + 1 > lastYear
                                      ? lastYear
                                      : value + 1;
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Debes seleccionar un año inicial';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '-',
                          style: TextStyle(fontSize: 40),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: endYear,
                            dropdownColor:
                                Theme.of(context).colorScheme.surface,
                            menuMaxHeight: 300,
                            borderRadius: BorderRadius.circular(12),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            items: yearOptions
                                .map((year) => DropdownMenuItem(
                                      value: year,
                                      child: Text(year.toString()),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  endYear = value;
                                  final firstYear = yearOptions.first;
                                  startYear = value - 1 < firstYear
                                      ? firstYear
                                      : value - 1;
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Debes seleccionar un año final';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SaveFormButton(
                      submitForm: () {
                        _submitForm();
                      },
                    ),
                    Text(
                      'Temporadas registradas',
                      style: textStyles.titleLarge,
                    ),
                    (savedSeasons.isEmpty)
                        ? const Text('No tienes temporadas guardadas')
                        : SizedBox(
                            height: 400,
                            child: ListView.builder(
                              itemCount: savedSeasons.length,
                              itemBuilder: (context, index) {
                                final seasonSaved = savedSeasons[index];
                                return Row(children: [
                                  Text(
                                    seasonSaved.season,
                                    style: textStyles.bodyLarge,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          updatingSeason = true;
                                          updateSeasonId = seasonSaved.id;
                                          startYear = int.parse(
                                              seasonSaved.season.split('-')[0]);
                                          endYear = int.parse(
                                              seasonSaved.season.split('-')[1]);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 18,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        showDefaultDialog(
                                          context,
                                          '¿Estás seguro de que deseas borrar esta temporada? Se borraran todas las estadísticas relacionadas con la misma',
                                          'Aceptar',
                                          'Cancelar',
                                          () => context.pop(),
                                          () {
                                            for (Stats stat
                                                in seasonSaved.stats) {
                                              ref
                                                  .read(statsProvider.notifier)
                                                  .deleteStats(stat.id);
                                            }
                                            for (ManagerTournamentStat mngtStat
                                                in seasonSaved
                                                    .managerTournamentStats) {
                                              ref
                                                  .read(
                                                      managerTournamentStatsProvider
                                                          .notifier)
                                                  .deleteManagerTournamentStat(
                                                      mngtStat.id);
                                            }
                                            for (Managerstat mngStat
                                                in seasonSaved.managerStats) {
                                              ref
                                                  .read(managerStatsProvider
                                                      .notifier)
                                                  .deleteManagerStat(
                                                      mngStat.id);
                                            }
                                            ref
                                                .read(seasonsProvider.notifier)
                                                .deleteSeason(seasonSaved.id);
                                            context.pop();
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 18,
                                      ))
                                ]);
                              },
                            ),
                          ),
                  ],
                ),
              )),
        ));
  }
}
