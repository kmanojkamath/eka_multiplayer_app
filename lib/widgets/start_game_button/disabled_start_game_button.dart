import 'package:flutter/material.dart';

class DisabledStartGameButton extends StatelessWidget {
  const DisabledStartGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.grey,
                  Color(0xFF9E9E9E),
                  Color(0xFF757575),
                  Color(0xFFBDBDBD),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(22),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 52,
                color: Colors.white70,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "START GAME",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
