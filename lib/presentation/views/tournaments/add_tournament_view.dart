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
      appBar: AppBar(
        title: Text((tournamentId == null) ? 'Crear torneo' : 'Editar torneo'),
      ),
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
  void submitTournament(Tournament tournament) {
    ref.read(tournamentsProvider.notifier).addTournament(tournament, imageFile);
  }

  void updateTournament(Tournament tournament) {
    ref.read(tournamentsProvider.notifier).updateTournament(
        int.parse(widget.tournamentId!), tournament, imageFile);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (widget.tournamentId != null) {
        Tournament tournamentToUpdate =
            Tournament(name: name, logoURL: logoURL);
        updateTournament(tournamentToUpdate);
        context.pop();
      } else {
        final tournament = Tournament(name: name, logoURL: logoURL);
        _formKey.currentState!.reset();
        submitTournament(tournament);
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
      getOldTournamentInfo();
    }
  }

  final _formKey = GlobalKey<FormState>();
  String name = '';
  String logoURL = '';
  XFile? imageFile;
  Tournament? oldTournament;
  @override
  Widget build(BuildContext context) {
    List<Tournament> savedTournaments =
        ref.watch(tournamentsProvider).values.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
              const Text('Torneos registrados'),
              (savedTournaments.isEmpty)
                  ? const Text('No tienes torneos guardados')
                  : SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: savedTournaments.length,
                        itemBuilder: (context, index) {
                          final tournament = savedTournaments[index];
                          return Text(tournament.name);
                        },
                      ),
                    ),
            ],
          )),
    );
  }
}
