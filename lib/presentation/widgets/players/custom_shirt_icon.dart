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
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final path = Path();

    final width = size.width;
    final height = size.height;

    path.moveTo(width * 0.25, height * 0.8);

    path.lineTo(width * 0.25, height * 0.4);

    path.lineTo(width * 0.15, height * 0.5);
    path.lineTo(width * 0.1, height * 0.4);
    path.lineTo(width * 0.2, height * 0.3);

    path.lineTo(width * 0.3, height * 0.2);

    path.quadraticBezierTo(
        width * 0.5, height * 0.15, width * 0.7, height * 0.2);

    path.lineTo(width * 0.8, height * 0.3);

    path.lineTo(width * 0.9, height * 0.4);
    path.lineTo(width * 0.85, height * 0.5);
    path.lineTo(width * 0.75, height * 0.4);

    path.lineTo(width * 0.75, height * 0.8);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
