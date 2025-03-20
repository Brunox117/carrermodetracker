import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';
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

  final _formKey = GlobalKey<FormState>();
  final imagePicker = ImagePicker();

  String name = '';
  String number = '';
  String position = '';
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
                onChanged: (value) => name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El número es requerido';
                  }
                  return null;
                },
              ),
            ],
          )),
    );
  }
}
