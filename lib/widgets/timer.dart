import 'dart:math';
import 'package:flutter/material.dart';

class Timer extends StatelessWidget {
  final double progress;

  final double size;
  final double strokeWidth;

  const Timer({
    super.key,
    required this.progress,
    this.size = 100,
    this.strokeWidth = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GradientTimerPainter(
          progress: progress,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _GradientTimerPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  const _GradientTimerPainter({
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final rect = Rect.fromCircle(
      center: center,
      radius: (size.width - strokeWidth) / 2,
    );

    final backgroundPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(
      center,
      (size.width - strokeWidth) / 2,
      backgroundPaint,
    );

    final progressPaint = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2*pi,
        colors: const [
          Colors.blue,
          Colors.green,
          Colors.yellow,
          Colors.orange,
          Colors.deepOrange,
          Colors.red,
          Colors.brown
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      rect,
      0, // start from top
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GradientTimerPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}