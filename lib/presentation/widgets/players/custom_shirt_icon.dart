import 'package:flutter/material.dart';

class CustomShirtIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const CustomShirtIcon({
    super.key,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter:
            ShirtPainter(color: color ?? Theme.of(context).iconTheme.color!),
      ),
    );
  }
}

class ShirtPainter extends CustomPainter {
  final Color color;

  ShirtPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();

    // Dibujar una playera simple
    final width = size.width;
    final height = size.height;

    // Cuerpo de la playera
    path.moveTo(width * 0.3, height * 0.2); // Cuello izquierdo
    path.lineTo(width * 0.2, height * 0.3); // Hombro izquierdo
    path.lineTo(width * 0.2, height * 0.8); // Lado izquierdo
    path.lineTo(width * 0.8, height * 0.8); // Lado derecho
    path.lineTo(width * 0.8, height * 0.3); // Hombro derecho
    path.lineTo(width * 0.7, height * 0.2); // Cuello derecho
    path.close();

    // Mangas
    path.moveTo(width * 0.2, height * 0.3);
    path.lineTo(width * 0.1, height * 0.4);
    path.lineTo(width * 0.15, height * 0.5);
    path.lineTo(width * 0.25, height * 0.4);

    path.moveTo(width * 0.8, height * 0.3);
    path.lineTo(width * 0.9, height * 0.4);
    path.lineTo(width * 0.85, height * 0.5);
    path.lineTo(width * 0.75, height * 0.4);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
