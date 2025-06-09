import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell currentChild;
  const CustomBottomNavBar({super.key, required this.currentChild});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        elevation: 0,
        enableFeedback: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: currentChild.currentIndex,
        onTap: (value) => currentChild.goBranch(value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'DT',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Agregar",
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
            backgroundColor: Colors.purple,
          ),
        ]);
  }
}
