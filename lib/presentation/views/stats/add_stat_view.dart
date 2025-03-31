import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_number_form_field.dart';
import 'package:carrermodetracker/presentation/widgets/forms/save_form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddStatView extends StatelessWidget {
  final String id;
  const AddStatView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registra un partido'),
      ),
      body: _StatsForm(
        teamID: id,
      ),
    );
  }
}

class _StatsForm extends ConsumerStatefulWidget {
  final String teamID;
  const _StatsForm({required this.teamID});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __StatsFormState();
}

class __StatsFormState extends ConsumerState<_StatsForm> {
  final _formKey = GlobalKey<FormState>();
  int goals = 0;
  int assists = 0;
  int playedMatches = 0;
  // final season = IsarLink<Season>();
  // final tournament = IsarLink<Tournament>();
  // final player = IsarLink<Player>();

  void submitStat(Stats stat) {
    ref.read(statsProvider.notifier).saveStats(stat);
  }

  void submitForm() {
    print('Form submitted');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    CustomNumberFormField(
                      isBottomField: true,
                      isTopField: true,
                      label: 'Goles',
                      hint: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          goals = number;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomNumberFormField(
                      isBottomField: true,
                      isTopField: true,
                      label: 'Asistencias',
                      hint: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          goals = number;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomNumberFormField(
                      isBottomField: true,
                      isTopField: true,
                      label: 'Partidos jugados',
                      hint: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final number = int.tryParse(value);
                        if (number != null) {
                          goals = number;
                        }
                      },
                    ),
                  ],
                ),
              ),
              SaveFormButton(submitForm: submitForm)
            ],
          )),
    );
  }
}
