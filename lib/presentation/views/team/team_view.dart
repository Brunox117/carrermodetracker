import 'dart:io';

import 'package:carrermodetracker/config/helpers/show_default_dialog.dart';
import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class TeamView extends ConsumerWidget {
  final String id;
  const TeamView({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamAsync = ref.watch(teamProvider(int.parse(id)));
    final textStyles = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton.filledTonal(
                  onPressed: () {
                    context.push('/editteam/$id');
                  },
                  icon: const Icon(Icons.edit),
                ),
                const SizedBox(height: 1),
                IconButton.filledTonal(
                  onPressed: () {
                    showDefaultDialog(
                        context,
                        "¿Estás seguro de que deseas borrar el equipo?",
                        "Aceptar",
                        'Cancelar', () {
                      context.pop();
                    }, () {
                      context.pop();
                      context.pop();
                    });
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ),
      body: teamAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (team) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text(team.name, style: textStyles.titleLarge)),
                const SizedBox(
                  height: 10,
                ),
                (team.logoURL.isEmpty)
                    ? const SizedBox()
                    : SizedBox(
                        height: 200,
                        child: Image.file(
                          File(team.logoURL),
                          fit: BoxFit.contain,
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
