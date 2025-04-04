import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class TeamView extends StatelessWidget {
  final String id;
  const TeamView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      
          IconButton.filledTonal( onPressed: () {
            context.push('/editteam/$id');
          }, icon: const Icon(Icons.edit)),
      body: const Center(
        child: Text('TeamView'),
      ),
    );
  }
}
