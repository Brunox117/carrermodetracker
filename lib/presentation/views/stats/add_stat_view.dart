import 'package:flutter/material.dart';

class AddStatView extends StatelessWidget {
  const AddStatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registra un partido'),
      ),
      body: const Center(
        child: Text('AddStatView'),
      ),
    );
  }
}