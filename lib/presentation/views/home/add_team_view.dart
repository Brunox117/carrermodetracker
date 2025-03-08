import 'dart:io';

import 'package:carrermodetracker/config/helpers/save_image_in_localdb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';

class AddTeamView extends StatelessWidget {
  const AddTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar equipo'),
      ),
      body: _TeamForm(),
    );
  }
}

class _TeamForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __TeamFormState();
}

class __TeamFormState extends ConsumerState<_TeamForm> {
  void submitTeam(Team team) async {
    ref.read(teamsProvider.notifier).addTeam(team);
  }

  final _formKey = GlobalKey<FormState>();

  final imagePicker = ImagePicker();

  String name = '';
  String acronimos = '';
  String logoURL = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final team = Team(name: name, acronimos: acronimos, logoURL: logoURL);
      _formKey.currentState!.reset();
      submitTeam(team);
      context.go('/');
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
                onChanged: (value) => acronimos = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El acrónimo es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text("Agrega una imagen o toma una foto"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      final XFile? image = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );

                      if (image != null) {
                        await saveImageInLocalStorage(image, 'teams');
                      }
                    },
                    icon: const Icon(Icons.camera_enhance, size: 80),
                  ),
                  IconButton(
                    onPressed: () async {
                      final XFile? image = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (image != null) {
                        String url =
                            await saveImageInLocalStorage(image, 'teams');
                        setState(() {
                          logoURL = url;
                        });
                      }
                    },
                    icon: const Icon(Icons.image, size: 80),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              (logoURL.isNotEmpty)
                  ? SizedBox(
                      height: 200,
                      child: Image.file(
                        File(logoURL),
                        fit: BoxFit.contain,
                      ),
                    )
                  : const SizedBox(
                      height: 20,
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
