import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell currentChild;
  const CustomBottomNavBar({super.key, required this.currentChild});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(
                icon: Icons.home,
                label: 'Inicio',
                isSelected: currentChild.currentIndex == 0,
                onTap: () => currentChild.goBranch(0),
              ),
              _NavBarItem(
                icon: Icons.person,
                label: 'DT',
                isSelected: currentChild.currentIndex == 1,
                onTap: () => currentChild.goBranch(1),
              ),
              _NavBarItem(
                icon: Icons.add,
                label: 'Agregar',
                isSelected: currentChild.currentIndex == 2,
                onTap: () => currentChild.goBranch(2),
              ),
              _NavBarItem(
                icon: Icons.settings,
                label: 'Ajustes',
                isSelected: currentChild.currentIndex == 3,
                onTap: () => currentChild.goBranch(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
        reverseCurve: Curves.easeOutBack,
      ),
    );
    _elevationAnimation = Tween<double>(begin: 0.0, end: 4.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
        reverseCurve: Curves.easeOutBack,
      ),
    );
  }

  @override
  void didUpdateWidget(_NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, -_elevationAnimation.value),
                    child: Icon(
                      widget.icon,
                      color: widget.isSelected ? Colors.white : Colors.white70,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 100),
                  style: TextStyle(
                    color: widget.isSelected ? Colors.white : Colors.white70,
                    fontSize: 12,
                    fontWeight:
                        widget.isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  child: Text(widget.label),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
