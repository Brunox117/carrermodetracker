import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell currentChild;
  const CustomBottomNavBar({super.key, required this.currentChild});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        elevation: 0,
        enableFeedback: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: currentChild.currentIndex,
        onTap: (value) => currentChild.goBranch(value),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: colors.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'DT',
            backgroundColor: colors.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: "Agregar",
            backgroundColor: colors.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'Ajustes',
            backgroundColor: colors.primary,
          ),
        ]);
  }
}
