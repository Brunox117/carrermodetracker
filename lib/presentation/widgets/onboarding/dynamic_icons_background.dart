import 'package:flutter/material.dart';
import 'dart:math';

class DynamicIconsBackground extends StatelessWidget {
  const DynamicIconsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final screenSize = MediaQuery.of(context).size;

    // Lista de iconos relacionados con fútbol/FIFA
    final List<IconData> footballIcons = [
      Icons.sports_soccer,
      Icons.emoji_events,
      Icons.analytics,
      Icons.people,
      Icons.star,
      Icons.trending_up,
      Icons.sports,
      Icons.leaderboard,
      Icons.assessment,
      Icons.group,
      Icons.flag,
      Icons.timer,
      Icons.score,
      Icons.visibility,
    ];

    return Container(
      height: screenSize.height,
      width: screenSize.width,
      color: Colors.black87,
      child: Stack(
        children: List.generate(30, (index) {
          final double left = random.nextDouble() * screenSize.width;
          final double top = random.nextDouble() * screenSize.height * 0.5;
          final double size = 20 + random.nextDouble() * 40;
          final double opacity = 0.1 + random.nextDouble() * 0.2;
          final IconData icon =
              footballIcons[random.nextInt(footballIcons.length)];
          return Positioned(
            left: left,
            top: top,
            child: Opacity(
              opacity: opacity,
              child: Icon(
                icon,
                size: size,
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
    );
  }
}
