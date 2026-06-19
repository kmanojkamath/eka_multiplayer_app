import 'dart:math';

import 'package:flutter/material.dart';

final colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
];

class TossWheel extends CustomPainter {
  final int playerCount;
  const TossWheel({required this.playerCount});
  
  void drawArc(Canvas canvas, Size size, int index) {
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      2 * pi / playerCount * index,
      2 * pi / playerCount,
      true,
      Paint()..color = colors[index],
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < playerCount; i++) {
      drawArc(canvas, size, i);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TossWheelWidget extends StatelessWidget {
  final double size;
  final int playerCount;
  const TossWheelWidget({super.key, required this.size, required this.playerCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(painter: TossWheel(playerCount: playerCount)),
        ),
        
      ],
    );
  }
}