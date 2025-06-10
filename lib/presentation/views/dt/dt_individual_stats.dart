import 'package:carrermodetracker/presentation/providers/stats/manager_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DtIndividualStats extends ConsumerWidget {
  final String? managerId;
  const DtIndividualStats({super.key, required this.managerId});

  @override
  Widget build(BuildContext context, ref) {
    final statsFromManager = ref.watch(managerStatsProvider).values.toList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Estadísticas'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: ListView.builder(
            itemCount: statsFromManager.length,
            itemBuilder: (context, index) {
              final stat = statsFromManager[index];
              return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Row(
                      children: [
                        Text(
                            "${stat.season.value!.season.toString()} ${stat.team.value!.name}"),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              //TODO llevar a la pantalla de add con los ids de season y team
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              ref
                                  .read(managerStatsProvider.notifier)
                                  .deleteManagerStat(index);
                              //TODO borrar tambien los tournament manager stats
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ));
            },
          ))
        ]));
  }
}
