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
      floatingActionButton: IconButton.filledTonal(
        onPressed: () {
          context.push('/editteam/$id');
        },
        icon: const Icon(Icons.edit),
      ),
      body: teamAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (team) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text(team.name, style: textStyles.titleLarge)),
              ],
            ),
          );
        },
      ),
    );
  }
}
