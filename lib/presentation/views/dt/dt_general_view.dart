import 'package:carrermodetracker/presentation/providers/manager/managers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DtGeneralView extends ConsumerWidget {
  const DtGeneralView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(managersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(manager?.name ?? ''),
      ),
      body: (manager == null)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'No has creado tu perfil de entrenador aún',
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(onPressed: () {
                  context.push('/dtview/addDt');
                }, child: const Text('Crear perfil')),
              ],
            )
          : Center(
              child: Text(manager.name),
            ),
    );
  }
}
