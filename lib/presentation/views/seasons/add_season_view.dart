import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/presentation/providers/seasons/seasons_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  void submitSeason(Season season) {
    ref.read(seasonsProvider.notifier).saveSeason(season);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Season seasonToSave = Season(season: season);
      _formKey.currentState!.reset();
      submitSeason(seasonToSave);
    }
  }

  final _formKey = GlobalKey<FormState>();
  String season = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFormField(
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
              SaveFormButton(submitForm: _submitForm),
              SizedBox(height: MediaQuery.of(context).size.width * 0.3)
            ],
          )),
    );
  }
}
