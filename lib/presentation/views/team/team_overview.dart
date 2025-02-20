import 'package:flutter/material.dart';

class TeamOverview extends StatelessWidget {
  final String id;
  const TeamOverview({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeamOverview'),
      ),
      body: Center(
        child: Text('Se recibio el id: $id'),
      ),
    );
  }
}
