import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTeamButton extends StatelessWidget {
  const AddTeamButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/addteam'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: const Stack(
          children: [
            SizedBox.expand(),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 30,
              child: Icon(
                size: 100,
                Icons.add_circle_outline_rounded,
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Center(
                  child: Text(
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
                    'Agregar equipo',
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
