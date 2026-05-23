import '../card_widget.dart';

import 'package:flutter/material.dart';

import 'dart:math';

import '/items/card/card_logic.dart';

class WildSymbol extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //Rotate the canvas to draw the wild symbol at an angle
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(0.6);
    canvas.translate(-size.width / 2, -size.height / 2);

    canvas.drawOval(
      //Draw the white oval background of the wild symbol
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.81,
        height: size.height,
      ),
      Paint()..color = Colors.white,
    );

    canvas.drawArc(
      //Draw the blue quarter of the wild symbol
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.95 * 0.81,
        height: size.height * 0.95,
      ),
      0 - 0.21,
      pi / 2,
      true,
      Paint()..color = color(CardColor.blue),
    );

    canvas.drawArc(
      //Draw the yellow quarter of the wild symbol
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.95 * 0.81,
        height: size.height * 0.95,
      ),
      pi / 2 - 0.21,
      pi / 2,
      true,
      Paint()..color = color(CardColor.yellow),
    );

    canvas.drawArc(
      //Draw the red quarter of the wild symbol
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.95 * 0.81,
        height: size.height * 0.95,
      ),
      pi - 0.21,
      pi / 2,
      true,
      Paint()..color = color(CardColor.red),
    );

    canvas.drawArc(
      //Draw the green quarter of the wild symbol
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.95 * 0.81,
        height: size.height * 0.95,
      ),
      3 * pi / 2 - 0.21,
      pi / 2,
      true,
      Paint()..color = color(CardColor.green),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
