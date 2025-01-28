import 'package:flutter/material.dart';

class TopographicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.1) // Adjust the opacity
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Generate the topographic pattern
    for (double yOffset = 0; yOffset < size.height; yOffset += 40) {
      final path = Path();
      for (double x = 0; x < size.width; x += 20) {
        path.lineTo(
            x,
            yOffset +
                10 * (x % 60 == 0 ? 1 : 0.5) * (yOffset % 80 == 0 ? -1 : 1));
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
