import 'package:flutter/material.dart';

class PointerCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );

    final pointerPath = Path();

    pointerPath.moveTo(size.width / 2 - 3, 0);
    pointerPath.lineTo(size.width / 2 + 3, 0);
    pointerPath.lineTo(size.width / 2, 20);
    pointerPath.close();

    canvas.drawPath(pointerPath, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}