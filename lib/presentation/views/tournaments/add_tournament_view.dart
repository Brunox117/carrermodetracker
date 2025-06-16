import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_tournament_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:drops/drops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/add_image_widget.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';

class AddTournamentView extends StatelessWidget {
  final String? tournamentId;
  const AddTournamentView({
    super.key,
    this.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _TournamentForm(tournamentId),
    );
  }
}

class _TournamentForm extends ConsumerStatefulWidget {
  final String? tournamentId;
  const _TournamentForm(this.tournamentId);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __TournamentFormState();
}

class __TournamentFormState extends ConsumerState<_TournamentForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String logoURL = '';
  XFile? imageFile;
  Tournament? oldTournament;
  bool updatingTournament = false;
  int? updateTournamentId;

  void submitTournament(Tournament tournament) {
    ref.read(tournamentsProvider.notifier).addTournament(tournament, imageFile);
  }

  void updateTournament(Tournament tournament) {
    ref.read(tournamentsProvider.notifier).updateTournament(
        int.parse(widget.tournamentId!), tournament, imageFile);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (updatingTournament) {
        Tournament tournamentToUpdate =
            Tournament(name: name, logoURL: logoURL);
        updateTournament(tournamentToUpdate);
        Drops.show(
          shape: DropShape.squared,
          context,
          title: "Torneo actualizado correctamente!",
        );
        _formKey.currentState!.reset();
        setState(() {
          updatingTournament = false;
          updateTournamentId = null;
          name = '';
          logoURL = '';
          imageFile = null;
        });
      } else {
        final tournament = Tournament(name: name, logoURL: logoURL);
        submitTournament(tournament);
        Drops.show(
          shape: DropShape.squared,
          context,
          title: "Torneo creado correctamente!",
        );
        _formKey.currentState!.reset();
        setState(() {
          name = '';
          logoURL = '';
          imageFile = null;
        });
      }
    }
  }

  void getOldTournamentInfo() {
    oldTournament = ref.read(tournamentsProvider).values.firstWhere(
          (element) => element.id == int.parse(widget.tournamentId!),
        );

    setState(() {
      name = oldTournament!.name;
      logoURL = oldTournament!.logoURL;
    });
  }

  @override
  void initState() {
    super.initState();
    ref.read(tournamentsProvider.notifier).loadNextPage();
    if (widget.tournamentId != null) {
      updatingTournament = true;
      updateTournamentId = int.parse(widget.tournamentId!);
      getOldTournamentInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Tournament> savedTournaments =
        ref.watch(tournamentsProvider).values.toList();
    final textStyles = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title:
            Text((updatingTournament) ? 'Editando un torneo' : 'Crear torneo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                (updatingTournament)
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            updatingTournament = false;
                            updateTournamentId = null;
                            name = '';
                            logoURL = '';
                            imageFile = null;
                          });
                        },
                        child: const Text('Cancelar edición'))
                    : SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                CustomFormField(
                  key: ValueKey(name),
                  initialValue: name,
                  isTopField: true,
                  isBottomField: true,
                  hint: "Nombre del torneo",
                  onChanged: (value) => name = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Debes asignar un nombre al torneo';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                AddImageWidget(
                  key: (logoURL.isNotEmpty) ? ValueKey(logoURL) : null,
                  hintText: 'Agrega una imagen o sube una foto',
                  documentsFolder: 'tournament',
                  onImageUploaded: (selectedImage) {
                    setState(() => imageFile = selectedImage);
                  },
                ),
                SaveFormButton(submitForm: _submitForm),
                Text(
                  'Torneos registrados',
                  style: textStyles.titleLarge,
                ),
                (savedTournaments.isEmpty)
                    ? const Text('No tienes torneos guardados')
                    : SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: savedTournaments.length,
                          itemBuilder: (context, index) {
                            final tournament = savedTournaments[index];
                            return Row(
                              children: [
                                Text(
                                  tournament.name,
                                  style: textStyles.bodyLarge,
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      updatingTournament = true;
                                      updateTournamentId = tournament.id;
                                      name = tournament.name;
                                      logoURL = tournament.logoURL;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 18,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: const Text(
                                              '¿Estás seguro de que deseas borrar este torneo, esto borrara las estadísticas relacionadas con el mismo?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => context.pop(),
                                              child: const Text('Cancelar'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                updateTournamentId = null;
                                                updatingTournament = false;
                                                for (Stats stat
                                                    in tournament.stats) {
                                                  ref
                                                      .read(statsProvider
                                                          .notifier)
                                                      .deleteStats(stat.id);
                                                }
                                                for (ManagerTournamentStat mngtStat
                                                    in tournament
                                                        .managerTournamentStats) {
                                                  ref
                                                      .read(
                                                          managerTournamentStatsProvider
                                                              .notifier)
                                                      .deleteManagerTournamentStat(
                                                          mngtStat.id);
                                                }
                                                ref
                                                    .read(tournamentsProvider
                                                        .notifier)
                                                    .deleteTournament(
                                                        tournament.id);
                                                context.pop();
                                              },
                                              child: const Text('Aceptar'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 18,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
              ],
            )),
      ),
    );
  }
}
