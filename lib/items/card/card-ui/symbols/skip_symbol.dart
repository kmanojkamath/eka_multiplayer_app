import 'package:flutter/material.dart';

import 'dart:math';

class SkipSymbol extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      //Draw the outer circle of the skip symbol
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width / 7,
    );
    canvas.drawLine(
      //Draw the diagonal line of the skip symbol
      Offset(
        0.5 * size.width * (1 + 1 / sqrt2),
        0.5 * size.height * (1 - 1 / sqrt2),
      ),
      Offset(
        0.5 * size.width * (1 - 1 / sqrt2),
        0.5 * size.height * (1 + 1 / sqrt2),
      ),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width / 7,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
