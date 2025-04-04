import 'dart:io';

import 'package:carrermodetracker/config/helpers/image_utilities.dart';
import 'package:carrermodetracker/presentation/widgets/forms/add_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';

class AddTeamView extends StatelessWidget {
  final String? teamid;
  const AddTeamView({super.key, this.teamid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((teamid == null) ? 'Agregar equipo' : 'Editar equipo'),
      ),
      body: _TeamForm(
        teamid: teamid,
      ),
    );
  }
}

class _TeamForm extends ConsumerStatefulWidget {
  final String? teamid;

  const _TeamForm({required this.teamid});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __TeamFormState();
}

class __TeamFormState extends ConsumerState<_TeamForm> {
  void submitTeam(Team team) async {
    ref.read(teamsProvider.notifier).addTeam(team, _selectedLogoFile);
  }

  void updateTeam(Team team) async {
    team.id = int.parse(widget.teamid!);
    ref
        .read(teamsProvider.notifier)
        .updateTeam(int.parse(widget.teamid!), team, _selectedLogoFile);
  }

  final _formKey = GlobalKey<FormState>();

  final imagePicker = ImagePicker();

  String name = '';
  String acronimos = '';
  String logoURL = '';
  XFile? _selectedLogoFile;

  void getOldTeamInfo() async {
    Team oldTeam = await ref
        .read(teamsProvider.notifier)
        .getTeam(int.parse(widget.teamid!));
    setState(() {
      name = oldTeam.name;
      acronimos = oldTeam.acronimos;
      logoURL = oldTeam.logoURL;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.teamid != null) {
      getOldTeamInfo();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final team = Team(name: name, acronimos: acronimos, logoURL: logoURL);
      _formKey.currentState!.reset();
      if (widget.teamid == null) {
        submitTeam(team);
        context.go('/');
      } else {
        updateTeam(team);
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomFormField(
                isTopField: true,
                hint: "Nombre del equipo",
                key: ValueKey(name),
                initialValue: name,
                onChanged: (value) => name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                hint: "Acrónimo (FCB, RM, BVB)",
                key: ValueKey(acronimos),
                initialValue: acronimos,
                onChanged: (value) => acronimos = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El acrónimo es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              AddImageWidget(
                key: (logoURL.isNotEmpty) ? ValueKey(logoURL) : null,
                hintText: 'Agrega una imagen o toma una foto',
                documentsFolder: 'teams',
                onImageUploaded: (selectedImage) {
                  setState(() => _selectedLogoFile = selectedImage);
                },
                imageURLFromFather: logoURL,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: IconButton(
                  onPressed: () {
                    _submitForm();
                  },
                  icon: Icon(
                    Icons.save,
                    size: 70,
                    color: colors.secondary,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
