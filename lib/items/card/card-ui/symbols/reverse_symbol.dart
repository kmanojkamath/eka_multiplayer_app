import 'dart:math';

import 'package:flutter/material.dart';

class ReverseSymbol extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width / 4.2; //Base unit for symbol dimensions

    //Rotate the canvas to draw the reverse symbol at an angle
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-0.6);
    canvas.translate(-size.width / 2, -size.height / 2);

    canvas.drawArc(
      //Draw the upper quarter of the reverse symbol
      Rect.fromCenter(
        center: Offset(2.3 * x, size.height / 2 - 0.1 * x),
        width: 1.8 * x,
        height: 1.8 * x,
      ),
      pi,
      pi * 1 / 2,
      true,
      Paint()..color = Colors.white,
    );

    canvas.drawRRect(
      //Draw the upper rectangle of the reverse symbol
      RRect.fromLTRBR(
        2.3 * x,
        size.height / 2 - 1 * x,
        3.2 * x,
        size.height / 2 - 0.1 * x,
        Radius.zero,
      ),
      Paint()..color = Colors.white,
    );

    final upperTrianglePath =
        Path(); //Path to draw the upper triangle of the reverse symbol
    upperTrianglePath.moveTo(size.width, size.height / 2 - 0.55 * x);
    upperTrianglePath.lineTo(
      size.width - x,
      size.height / 2 - (0.55 - 0.81) * x,
    );
    upperTrianglePath.lineTo(
      size.width - x,
      size.height / 2 - (0.55 + 0.81) * x,
    );
    upperTrianglePath.close();

    canvas.drawPath(
      upperTrianglePath,
      Paint()..color = Colors.white,
    ); //Draw the upper triangle of the reverse symbol

    final lowerTrianglePath =
        Path(); //Path to draw the lower triangle of the reverse symbol
    lowerTrianglePath.moveTo(0, size.height / 2 + 0.55 * x);
    lowerTrianglePath.lineTo(x, size.height / 2 + (0.55 + 0.81) * x);
    lowerTrianglePath.lineTo(x, size.height / 2 + (0.55 - 0.81) * x);
    lowerTrianglePath.close();

    canvas.drawPath(
      lowerTrianglePath,
      Paint()..color = Colors.white,
    ); //Draw the lower triangle of the reverse symbol

    canvas.drawRRect(
      //Draw the lower rectangle of the reverse symbol
      RRect.fromLTRBR(
        x,
        size.height / 2 + 0.1 * x,
        1.9 * x,
        size.height / 2 + 1 * x,
        Radius.zero,
      ),
      Paint()..color = Colors.white,
    );

    canvas.drawArc(
      //Draw the lower quarter of the reverse symbol
      Rect.fromCenter(
        center: Offset(1.9 * x, size.height / 2 + 0.1 * x),
        width: 1.8 * x,
        height: 1.8 * x,
      ),
      0,
      pi / 2,
      true,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
