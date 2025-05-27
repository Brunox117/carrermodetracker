
import 'package:carrermodetracker/presentation/providers/manager/managers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DtGeneralView extends ConsumerWidget {
  const DtGeneralView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(managersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('DtGeneralView'),
      ),
      body: const Center(
        child: Text('DtGeneralView'),
      ),
    );
  }
}