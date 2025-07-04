import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterMatchView extends StatelessWidget {
  final String id;
  const RegisterMatchView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Registra partidos, agrega nuevos jugadores e inicia nuevas temporadas',
                  style: textStyles.bodyLarge?.copyWith(
                    color: colors.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildActionButton(
                  context,
                  icon: Icons.emoji_events,
                  text: 'Crea un torneo',
                  onPressed: () =>
                      context.push('/teamoverview/$id/addtournamentview'),
                ),
                _buildActionButton(
                  context,
                  icon: Icons.person_add,
                  text: 'Agregar jugador',
                  onPressed: () =>
                      context.push('/teamoverview/$id/addplayerview'),
                ),
                _buildActionButton(
                  context,
                  icon: Icons.bar_chart,
                  text: 'Registra estadísticas',
                  onPressed: () =>
                      context.push('/teamoverview/$id/addstatview'),
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
          ),
        ],
      ),
    ));
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
