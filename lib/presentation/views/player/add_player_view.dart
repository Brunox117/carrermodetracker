import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/enums/positions.dart';
import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/add_image_widget.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';
import 'package:carrermodetracker/presentation/widgets/shared/custom_dropdown_button.dart';
import 'package:drops/drops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:image_picker/image_picker.dart';

class AddPlayerView extends StatelessWidget {
  final String? playerId;
  final String teamId;
  const AddPlayerView({super.key, required this.teamId, this.playerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((playerId == null) ? 'Agregar jugador' : "Editar jugador"),
      ),
      body: _PlayerForm(
        teamId: teamId,
        playerId: playerId,
      ),
    );
  }
}

class _PlayerForm extends ConsumerStatefulWidget {
  final String teamId;
  final String? playerId;
  const _PlayerForm({required this.teamId, this.playerId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __PlayerFormState();
}

class __PlayerFormState extends ConsumerState<_PlayerForm> {
  void submitPlayer(Player player) {
    ref.read(playersProvider.notifier).addPlayer(player, imageFile);
  }

  void updatePlayer(Player player) {
    ref
        .read(playersProvider.notifier)
        .updatePlayer(int.parse(widget.playerId!), player, imageFile);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (widget.playerId != null) {
        final Team team = ref
            .read(teamsProvider)
            .values
            .firstWhere((element) => element.id == oldPlayer!.team.value!.id);
        Player player = Player(
            name: name,
            number: number,
            position: position.name.toString().toUpperCase())
          ..team.value = team;
        _formKey.currentState!.reset();
        updatePlayer(player);
        context.pop();
      } else {
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
  }

  void getOldPlayerInfo() {
    oldPlayer = ref.read(playersProvider).values.firstWhere(
          (element) => element.id == (int.parse(widget.playerId!)),
        );
    setState(() {
      name = oldPlayer!.name;
      number = oldPlayer!.number;
      imageURL = oldPlayer!.imageURL;
      position = Positions.values.firstWhere(
        (element) =>
            element.name.toString().toUpperCase() == oldPlayer!.position,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.playerId != null) {
      getOldPlayerInfo();
    }
  }

  final _formKey = GlobalKey<FormState>();

  String name = '';
  String number = '';
  Positions position = Positions.dc;
  String imageURL = '';
  XFile? imageFile;
  Player? oldPlayer;

  @override
  Widget build(BuildContext context) {
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
                height: 15,
              ),
              CustomFormField(
                isTopField: true,
                key: ValueKey(number),
                initialValue: number,
                isBottomField: true,
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
              CustomDropdownButtonFormField(
                items: Positions.values.map((Positions position1) {
                  return DropdownMenuItem<Positions>(
                      value: position1,
                      child: Text(position1.name.toUpperCase()));
                }).toList(),
                value: position,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      position = value;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              AddImageWidget(
                key: (imageURL.isNotEmpty) ? ValueKey(imageURL) : null,
                hintText: 'Agrega una imagen o sube una foto',
                documentsFolder: 'players',
                onImageUploaded: (selectedImage) {
                  setState(() => imageFile = selectedImage);
                },
                imageURLFromFather: imageURL,
              ),
              const SizedBox(
                height: 20,
              ),
              SaveFormButton(
                submitForm: _submitForm,
                onSaveTextAlert: "Jugador guardado exitosamente!",
              ),
            ],
          )),
    );
  }
}
