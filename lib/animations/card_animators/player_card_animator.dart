part of 'card_animator.dart';

extension PlayerCardAnimator on CardAnimator {
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
}