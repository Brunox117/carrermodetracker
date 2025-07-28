import 'package:carrermodetracker/presentation/widgets/onboarding/feature_card.dart';
import 'package:carrermodetracker/presentation/widgets/onboarding/onboarding_carousel.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> features = [
      const FeatureCard(
        icon: Icons.analytics,
        title: 'Estadísticas Detalladas',
        description:
            'Registra y analiza cada aspecto de tu carrera: goles, asistencias, partidos jugados y mucho más.',
      ),
      const FeatureCard(
        icon: Icons.people,
        title: 'Gestión de Jugadores',
        description:
            'Administra tu plantilla completa con perfiles individuales, posiciones y rendimiento detallado.',
      ),
      const FeatureCard(
        icon: Icons.emoji_events,
        title: 'Seguimiento de Torneos',
        description:
            'Monitorea tu progreso en ligas, copas y competiciones internacionales con estadísticas específicas.',
      ),
    ];
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.black87,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 9, 96, 4),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¡Bienvenido a CarrerModeTracker!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tu compañero definitivo para dominar el modo carrera de FIFA',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    OnboardingCarousel(
                      carouselWidgets: features,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
