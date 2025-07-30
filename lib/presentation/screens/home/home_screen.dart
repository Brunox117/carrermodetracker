import 'package:carrermodetracker/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:carrermodetracker/presentation/widgets/shared/custom_bottom_navbar.dart';
import 'package:carrermodetracker/plugins/shared_preferences_plugin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final StatefulNavigationShell currentChild;
  const HomeScreen({super.key, required this.currentChild});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showOnboarding = true;
  bool _isLoading = true;

  static const String _onboardingKey = 'onboarding_completed';

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _completeOnboarding() async {
    await SharePreferencesPlugin.setBool(_onboardingKey, true);
    if (mounted) {
      setState(() {
        _showOnboarding = false;
      });
    }
  }

  Future<void> _checkOnboardingStatus() async {
    final onboardingCompleted =
        await SharePreferencesPlugin.getBool(_onboardingKey) ?? false;

    if (mounted) {
      setState(() {
        _showOnboarding = !onboardingCompleted;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_showOnboarding) {
      return OnboardingScreen(
        completeOnboarding: _completeOnboarding,
      );
    }

    return Scaffold(
      body: widget.currentChild,
      bottomNavigationBar:
          CustomBottomNavBar(currentChild: widget.currentChild),
    );
  }
}
