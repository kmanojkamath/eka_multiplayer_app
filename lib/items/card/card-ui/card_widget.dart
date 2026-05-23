import 'dart:math';

import '../animated-cards/animated_card.dart';
import '../card_logic.dart';

import 'card_symbols.dart';

import 'package:flutter/material.dart';

Color color(CardColor cardcolor) {
  switch (cardcolor) {
    case CardColor.red:
      return Colors.red;
    case CardColor.green:
      return Colors.green;
    case CardColor.blue:
      return Colors.blue;
    case CardColor.yellow:
      return Colors.amberAccent;
    case CardColor.wild:
      return Colors.black;
  }
}

class EkaCardWidget extends StatelessWidget {
  final EkaCard _card;
  const EkaCardWidget(this._card, {super.key}); //Default card height is 281

  @override
  Widget build(BuildContext context) {
    return Stack(
      //Stack to layer the card background and symbols
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
          //Colored background of the card based on its color
          width: 168 * 0.4,
          height: 261 * 0.4,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.black, color(_card.color)],
            ),
            color: color(_card.color),
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
                      color(_card.color),
                      width: 177 * 0.4,
                      height: 216 * 0.4,
                      angle: 0.6,
                    ),
                  ),
                ),
                Align(
                  //Top left symbol of the card
                  alignment: AlignmentGeometry.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      _card.isDrawTwo || _card.isWildDrawFour
                          ? 8 * 0.4
                          : 16 * 0.4,
                      _card.isSkip || _card.isWildCard
                          ? 16 * 0.4
                          : _card.isReverse
                          ? 12 * 0.4
                          : 0,
                      0,
                      0,
                    ),
                    child: Symbol(_card),
                  ),
                ),
                Align(
                  //Bottom right symbol of the card, flipped and rotated to match the top left symbol
                  alignment: AlignmentGeometry.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      0,
                      _card.isDrawTwo || _card.isWildDrawFour
                          ? 8 * 0.4
                          : 16 * 0.4,
                      _card.isSkip || _card.isWildCard ? 16 * 0.4 : 0,
                    ),
                    child: Transform.flip(
                      flipY: true,
                      flipX: true,
                      child: Symbol(_card),
                    ),
                  ),
                ),
                Align(
                  //Middle symbol of the card, larger and italicized for number cards, and larger for action cards
                  alignment: AlignmentGeometry.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: _card.isWildDrawFour
                        ? Symbol(
                            EkaCard(100, CardController()),
                            isMiddleSymbol: true,
                          )
                        : Symbol(_card, isMiddleSymbol: true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CenterOval extends CustomPainter {
  //CustomPainter to draw the center oval background of the card
  final Color color;
  final double width;
  final double height;
  final double angle;
  CenterOval(
    this.color, {
    required this.width,
    required this.height,
    required this.angle,
  });
  @override
  void paint(Canvas canvas, Size size) {
    double a = sqrt(
      (width * width * cos(angle) * cos(angle) -
              height * height * sin(angle) * sin(angle)) /
          (cos(angle) * cos(angle) - sin(angle) * sin(angle)),
    ); //Calculate the semi-major axis of the oval based on the width, height, and rotation angle of the card
    double b = sqrt(
      (height * height * cos(angle) * cos(angle) -
              width * width * sin(angle) * sin(angle)) /
          (cos(angle) * cos(angle) - sin(angle) * sin(angle)),
    ); //Calculate the semi-minor axis of the oval based on the width, height, and rotation angle of the card

    //Rotate the canvas to draw the oval at the correct angle, and then draw the oval with a white border and the card color as the fill
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(angle);
    canvas.translate(-size.width / 2, -size.height / 2);

    canvas.drawOval(
      //Draw the white border of the oval
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: a,
        height: b,
      ),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 1 * height / 216,
    );
    canvas.drawOval(
      //Draw the colored fill of the oval
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: a - 10 * height / 216,
        height: b - 10 * height / 216,
      ),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
