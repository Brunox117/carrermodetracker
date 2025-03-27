import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/enums/positions.dart';
import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/add_image_widget.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';

class AddPlayerView extends StatelessWidget {
  final String id;
  const AddPlayerView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar jugador'),
      ),
      body: _PlayerForm(teamId: id),
    );
  }
}

class _PlayerForm extends ConsumerStatefulWidget {
  final String teamId;
  const _PlayerForm({required this.teamId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __PlayerFormState();
}

class __PlayerFormState extends ConsumerState<_PlayerForm> {
  void submitPlayer(Player player) {
    ref.read(playersProvider.notifier).addPlayer(player);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Team team = await ref
          .read(teamsProvider.notifier)
          .getTeam(int.parse(widget.teamId));

      Player player = Player(
          name: name,
          number: number,
          position: position.name.toString().toUpperCase())
        ..team.value = team;
      if (imageURL.isNotEmpty) {
        player.imageURL = imageURL;
      }
      _formKey.currentState!.reset();
      submitPlayer(player);
    }
  }

  final _formKey = GlobalKey<FormState>();

  String name = '';
  String number = '';
  Positions position = Positions.dc;
  String imageURL = '';

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
                hint: "Nombre del jugador",
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
                isTopField: false,
                hint: "Número del jugador",
                keyboardType: TextInputType.number,
                onChanged: (value) => number = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El número es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton<Positions>(
                  alignment: Alignment.center,
                  value: position,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        position = value;
                      });
                    }
                  },
                  items: Positions.values.map((Positions position1) {
                    return DropdownMenuItem<Positions>(
                        value: position1,
                        child: Text(position1.name.toUpperCase()));
                  }).toList()),
              const SizedBox(
                height: 10,
              ),
              AddImageWidget(
                hintText: 'Agrega una imagen o sube una foto',
                documentsFolder: 'players',
                onImageUploaded: (url) {
                  setState(() => imageURL = url);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SaveFormButton(submitForm: _submitForm),
            ],
          )),
    );
  }
}
