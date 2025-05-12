import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carrermodetracker/domain/entities/player.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final int totalPlayedMatches;
  final int totalGoals;
  final int totalAssists;

  const PlayerCard({
    super.key,
    required this.player,
    required this.totalPlayedMatches,
    required this.totalGoals,
    required this.totalAssists,
  });

  @override
  Widget build(BuildContext context) {
    File? imageFile = (player.imageURL == "") ? null : File(player.imageURL);
    if (imageFile != null && !imageFile.existsSync()) {
      imageFile = null;
    }

    return Card(
      child: Column(
        children: [
          if (imageFile != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.file(
                imageFile,
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  player.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatCard(
                      context,
                      'Partidos',
                      totalPlayedMatches.toString(),
                      Icons.sports_score,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      context,
                      'Goles',
                      totalGoals.toString(),
                      Icons.sports_soccer,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      context,
                      'Asistencias',
                      totalAssists.toString(),
                      Icons.assistant_outlined,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: colors.primary),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
