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
      ..strokeWidth = 2.0
      // Estas propiedades hacen que las uniones y los finales de línea sean redondeados,
      // lo que da un aspecto más suave.
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final path = Path();

    final width = size.width;
    final height = size.height;

    // Se dibuja la playera como un único contorno continuo para evitar
    // que las líneas del cuerpo atraviesen las mangas.

    // Empezar en la parte inferior izquierda del cuerpo
    path.moveTo(width * 0.25, height * 0.8);

    // Lado izquierdo del cuerpo hasta la axila
    path.lineTo(width * 0.25, height * 0.4);

    // Dibujar la manga izquierda desde la axila
    path.lineTo(
        width * 0.15, height * 0.5); // Parte inferior externa de la manga
    path.lineTo(
        width * 0.1, height * 0.4); // Parte superior externa de la manga
    path.lineTo(width * 0.2, height * 0.3); // Hombro

    // Dibujar el cuello
    path.lineTo(width * 0.3, height * 0.2); // Lado izquierdo del cuello

    // Usamos una curva de Bézier para un cuello más natural
    path.quadraticBezierTo(
        width * 0.5, height * 0.15, width * 0.7, height * 0.2);

    // Hombro derecho
    path.lineTo(width * 0.8, height * 0.3);

    // Dibujar la manga derecha
    path.lineTo(
        width * 0.9, height * 0.4); // Parte superior externa de la manga
    path.lineTo(
        width * 0.85, height * 0.5); // Parte inferior externa de la manga
    path.lineTo(width * 0.75, height * 0.4); // Axila

    // Lado derecho del cuerpo hasta la parte inferior
    path.lineTo(width * 0.75, height * 0.8);

    // Cerrar el camino dibujará la línea inferior de la playera
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
