import 'package:flutter/material.dart';

import '../animated-cards/animated_back_card.dart';
import '../card_storage.dart';

class CardAnimator {
  final CardStorage cardStorage;

  const CardAnimator(this.cardStorage);

  List<Future> moveCard(
    int ci, {
    int? duration,
    Offset? position,
    int posDuration = 0,
    Curve posCurve = Curves.linear,
    double? angle,
    int angleDuration = 0,
    Curve angleCurve = Curves.linear,
    double? scale,
    int scaleDuration = 0,
    Curve scaleCurve = Curves.linear,
    double? widthScale,
    int widthScaleDuration = 0,
    Curve widthScaleCurve = Curves.linear,
  }) => [
    if (position != null)
      cardStorage.card[ci].controller.changePosition!.call(
        position,
        Duration(milliseconds: duration ?? posDuration),
        posCurve,
      ),
    if (angle != null)
      cardStorage.card[ci].controller.changeAngle!.call(
        angle,
        Duration(milliseconds: duration ?? angleDuration),
        angleCurve,
      ),
    if (scale != null)
      cardStorage.card[ci].controller.changeScale!.call(
        scale,
        Duration(milliseconds: duration ?? scaleDuration),
        scaleCurve,
      ),
    if (widthScale != null)
      cardStorage.card[ci].controller.changeWidthScale!.call(
        widthScale,
        Duration(milliseconds: duration ?? widthScaleDuration),
        widthScaleCurve,
      ),
  ];

  List<Future> moveBackCard({
    Offset? position,
    int? duration,
    int posDuration = 0,
    Curve posCurve = Curves.linear,
    double? angle,
    int angleDuration = 0,
    Curve angleCurve = Curves.linear,
    double? scale,
    int scaleDuration = 0,
    Curve scaleCurve = Curves.linear,
    double? widthScale,
    int widthScaleDuration = 0,
    Curve widthScaleCurve = Curves.linear,
  }) => [
    if (position != null)
      cardStorage.backOfDrawingCard.changePosition!.call(
        position,
        Duration(milliseconds: duration ?? posDuration),
        posCurve,
      ),
    if (angle != null)
      cardStorage.backOfDrawingCard.changeAngle!.call(
        angle,
        Duration(milliseconds: duration ?? angleDuration),
        angleCurve,
      ),
    if (scale != null)
      cardStorage.backOfDrawingCard.changeScale!.call(
        scale,
        Duration(milliseconds: duration ?? scaleDuration),
        scaleCurve,
      ),
    if (widthScale != null)
      cardStorage.backOfDrawingCard.changeWidthScale!.call(
        widthScale,
        Duration(milliseconds: duration ?? widthScaleDuration),
        widthScaleCurve,
      ),
  ];

  List<Future> movePlayerCard(
    BackCardController playerCard, {
    Offset? position,
    int? duration,
    int posDuration = 0,
    Curve posCurve = Curves.linear,
    double? angle,
    int angleDuration = 0,
    Curve angleCurve = Curves.linear,
    double? scale,
    int scaleDuration = 0,
    Curve scaleCurve = Curves.linear,
    double? widthScale,
    int widthScaleDuration = 0,
    Curve widthScaleCurve = Curves.linear,
  }) => [
    if (position != null)
      playerCard.changePosition!.call(
        position,
        Duration(milliseconds: duration ?? posDuration),
        posCurve,
      ),
    if (angle != null)
      playerCard.changeAngle!.call(
        angle,
        Duration(milliseconds: duration ?? angleDuration),
        angleCurve,
      ),
    if (scale != null)
      playerCard.changeScale!.call(
        scale,
        Duration(milliseconds: duration ?? scaleDuration),
        scaleCurve,
      ),
    if (widthScale != null)
      playerCard.changeWidthScale!.call(
        widthScale,
        Duration(milliseconds: duration ?? widthScaleDuration),
        widthScaleCurve,
      ),
  ];

  List<Future> moveTopCard({
    Offset? position,
    int? duration,
    int posDuration = 0,
    Curve posCurve = Curves.linear,
    double? angle,
    int angleDuration = 0,
    Curve angleCurve = Curves.linear,
    double? scale,
    int scaleDuration = 0,
    Curve scaleCurve = Curves.linear,
    double? widthScale,
    int widthScaleDuration = 0,
    Curve widthScaleCurve = Curves.linear,
  }) => [
    if (position != null)
      cardStorage.topCard.controller.changePosition!.call(
        position,
        Duration(milliseconds: duration ?? posDuration),
        posCurve,
      ),
    if (angle != null)
      cardStorage.topCard.controller.changeAngle!.call(
        angle,
        Duration(milliseconds: duration ?? angleDuration),
        angleCurve,
      ),
    if (scale != null)
      cardStorage.topCard.controller.changeScale!.call(
        scale,
        Duration(milliseconds: duration ?? scaleDuration),
        scaleCurve,
      ),
    if (widthScale != null)
      cardStorage.topCard.controller.changeWidthScale!.call(
        widthScale,
        Duration(milliseconds: duration ?? widthScaleDuration),
        widthScaleCurve,
      ),
  ];
}
