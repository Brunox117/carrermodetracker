import 'package:carrermodetracker/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:carrermodetracker/presentation/widgets/shared/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell currentChild;
  const HomeScreen({super.key, required this.currentChild});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen();
  }
}
