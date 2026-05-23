import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.center,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            colors: [Colors.amber, Colors.brown],
          ),
        ),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
      ),
    );
  }
}
