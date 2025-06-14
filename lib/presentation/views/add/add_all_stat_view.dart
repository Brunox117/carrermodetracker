import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAllStatView extends StatelessWidget {
  final String id;
  const AddAllStatView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estadisticas"),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              _buildActionButton(
                context,
                icon: Icons.emoji_events_outlined,
                text: 'Crea un torneo',
                onPressed: () =>
                    context.push('/teamoverview/$id/addtournamentview'),
              ),
              _buildActionButton(
                context,
                icon: Icons.shield_outlined,
                text: 'Crea un equipo',
                onPressed: () => context.push('/addteam'),
              ),
              _buildActionButton(
                context,
                icon: Icons.person_add,
                text: 'Agrega un jugador',
                onPressed: () =>
                    context.push('/add-all-stat-view/addplayerview'),
              ),
              _buildActionButton(
                context,
                icon: Icons.calendar_today,
                text: 'Iniciar nueva temporada',
                onPressed: () =>
                    context.push('/teamoverview/$id/addseasonview'),
              ),
            ],
          ),
        ],
      )),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: () {
          onPressed();
        },
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
