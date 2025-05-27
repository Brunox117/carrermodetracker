import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell currentChild;
  const CustomBottomNavBar({super.key, required this.currentChild});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
        enableFeedback: true,
        currentIndex: currentChild.currentIndex,
        onTap: (value) => currentChild.goBranch(value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'DT'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ]);
  }
}
