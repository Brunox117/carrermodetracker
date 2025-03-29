import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/presentation/providers/seasons/seasons_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddSeasonView extends StatelessWidget {
  const AddSeasonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agrega una temporada'),
      ),
      body: const _SeasonForm(),
    );
  }
}

class _SeasonForm extends ConsumerStatefulWidget {
  const _SeasonForm();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __SeasonFormState();
}

class __SeasonFormState extends ConsumerState<_SeasonForm> {
  final _formKey = GlobalKey<FormState>();
  String season = '';
  List<Season> savedSeasons = [];

  void submitSeason(Season seasonTS) {
    ref.read(seasonsProvider.notifier).saveSeason(seasonTS);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Season seasonToSave = Season(season: season);
      bool seasonExists =
          savedSeasons.any((s) => s.season == seasonToSave.season);
      if (seasonExists) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text(
                  'Ya tienes al menos una temporada con este nombre. ¿Estas seguro de que deseas guardar otra con el mismo nombre?'),
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text("No, cambiar nombre"),
                ),
                TextButton(
                  onPressed: () {
                    submitSeason(seasonToSave);
                    _formKey.currentState!.reset();
                    context.pop();
                    setState(() {
                      season = '';
                    });
                  },
                  child: const Text("Aceptar"),
                ),
              ],
            );
          },
        );
      } else {
        submitSeason(seasonToSave);
        _formKey.currentState!.reset();
        setState(() {
          season = '';
        });
      }
    }
  }

  void getSeasons() async {
    ref.read(seasonsProvider.notifier).getSeasons();
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final currentYear = now.month > 6 ? now.year : now.year - 1;
    season = '$currentYear-${currentYear + 1}';
    getSeasons();
  }

  @override
  Widget build(BuildContext context) {
    final seasonsMap = ref.watch(seasonsProvider);
    savedSeasons = seasonsMap.values.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              CustomFormField(
                initialValue: season,
                isTopField: true,
                isBottomField: true,
                hint: 'Agrega la temporada (2024-2025)',
                onChanged: (value) => season = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Debes asignar un valor a la temporada';
                  }
                  return null;
                },
              ),
              SaveFormButton(
                submitForm: () {
                  _submitForm();
                },
              ),
              const Text('Temporadas registradas'),
              (savedSeasons.isEmpty)
                  ? const Text('No tienes temporadas guardadas')
                  : SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: savedSeasons.length,
                        itemBuilder: (context, index) {
                          final seasonSaved = savedSeasons[index];
                          return Text(seasonSaved.season);
                        },
                      ),
                    ),
            ],
          )),
    );
  }
}
