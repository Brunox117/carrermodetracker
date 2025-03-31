import 'package:carrermodetracker/domain/entities/stats.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:carrermodetracker/presentation/widgets/forms/custom_form_field.dart';
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
  String goals = '';
  String assists = '';
  String playedMatches = '';
  // final season = IsarLink<Season>();
  // final tournament = IsarLink<Tournament>();
  // final player = IsarLink<Player>();

  void submitStat(Stats stat) {
    ref.read(statsProvider.notifier).saveStats(stat);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                initialValue: goals,
                isTopField: true,
                isBottomField: true,
                hint: 'Agrega la temporada (2024-2025)',
                onChanged: (value) => goals = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Debes asignar un valor a la temporada';
                  }
                  return null;
                },
              ),
            ],
          )),
    );
  }
}
