import 'card_widget.dart';

import '../card_logic.dart';

import 'package:flutter/material.dart';

class BackCardWidget extends StatelessWidget {
  const BackCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Container(
          //White background of the card
          width: 0.4 * 188,
          height: 0.4 * 281,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12 * 0.4),
            border: Border.all(color: Colors.black, width: 0.5 * 0.4),
          ),
        ),
        Container(
          //Black background of the card
          width: 168 * 0.4,
          height: 261 * 0.4,
          decoration: BoxDecoration(
            color: color(CardColor.wild),
            borderRadius: BorderRadius.circular(12 * 0.4),
          ),
          child: SizedBox(
            //SizedBox to set the size of the card symbols
            width: 178 * 0.4,
            height: 210 * 0.4,
            child: Stack(
              children: [
                Align(
                  //Center ovel background
                  alignment: AlignmentGeometry.center,
                  child: CustomPaint(
                    painter: CenterOval(
                      //CustomPainter to draw the center oval background of the card
                      color(CardColor.wild),
                      width: 177 * 0.4,
                      height: 216 * 0.4,
                      angle: 0.6,
                    ),
                  ),
                ),
                Align(
                  //Top left symbol of the card
                  alignment: AlignmentGeometry.topLeft,
                  child: SizedBox.shrink(),
                ),
                Align(
                  //Bottom right symbol of the card, flipped and rotated to match the top left symbol
                  alignment: AlignmentGeometry.bottomRight,
                  child: SizedBox.shrink(),
                ),
                Align(
                  //Middle symbol of the card, larger and italicized for number cards, and larger for action cards
                  alignment: AlignmentGeometry.center,
                  child: SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
