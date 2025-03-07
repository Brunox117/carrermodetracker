import 'package:flutter/material.dart';

class AddPlayerView extends StatelessWidget {
  final String id;
  const AddPlayerView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar jugador'),
      ),
      body: Column(
        children: [
          Text("Agregar jugador al equipo $id"),
        ],
      ),
    );
  }
}
