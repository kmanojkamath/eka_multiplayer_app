import 'package:flutter/material.dart';

import '../card/card_animations/positions.dart';

class NamePlate extends StatelessWidget {
  final Positions positions;
  final String playerName;
  const NamePlate(this.positions, this.playerName, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: positions.screenSize.width * 0.26,
      height: positions.screenSize.height * 0.10,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
          width: positions.screenSize.width * 0.25,
          height: positions.screenSize.height * 0.09,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                playerName,
                style: TextStyle(
                  fontSize: positions.screenSize.width * 0.022,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}