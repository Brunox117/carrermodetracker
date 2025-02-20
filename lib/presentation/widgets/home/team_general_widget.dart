
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeamGeneralWidget extends StatelessWidget {
  final String nombreEquipo;
  const TeamGeneralWidget({super.key, required this.nombreEquipo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/teamoverview/${1}'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.lightBlue.withOpacity(.6),
            borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            const SizedBox.expand(),
            const Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 30,
              child: Icon(
                size: 100,
                Icons.circle,
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Center(
                  child: Text(
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 19),
                    nombreEquipo,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
