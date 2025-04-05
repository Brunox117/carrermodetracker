import 'package:flutter/material.dart';

class PlayerOverview extends StatelessWidget {
  const PlayerOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlayerOverview'),
      ),
      body: const Center(
        child: Text('PlayerOverview'),
      ),
    );
  }
}