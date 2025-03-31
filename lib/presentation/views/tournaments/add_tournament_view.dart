import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/add_image_widget.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTournamentView extends StatelessWidget {
  const AddTournamentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear torneo'),
      ),
      body: const _TournamentForm(),
    );
  }
}

class _TournamentForm extends ConsumerStatefulWidget {
  const _TournamentForm();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __TournamentFormState();
}

class __TournamentFormState extends ConsumerState<_TournamentForm> {
  void submitTournament(Tournament tournament) {
    ref.read(tournamentsProvider.notifier).addTournament(tournament);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final tournament = Tournament(name: name, logoURL: logoURL);
      _formKey.currentState!.reset();
      submitTournament(tournament);
    }
  }

  final _formKey = GlobalKey<FormState>();
  String name = '';
  String logoURL = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomFormField(
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
                hintText: 'Agrega una imagen o sube una foto',
                documentsFolder: 'tournament',
                onImageUploaded: (url) {
                  setState(() => logoURL = url);
                },
              ),
              SaveFormButton(submitForm: _submitForm),
            ],
          )),
    );
  }
}
