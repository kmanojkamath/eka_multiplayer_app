import 'package:flutter/material.dart';

class ColorSquare extends StatelessWidget {
  final Color color;

  const ColorSquare({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).height * 0.075;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.15),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 3),
            color: Colors.black.withValues(alpha: 0.12),
          ),
        ],
      ),
    );
  }
}