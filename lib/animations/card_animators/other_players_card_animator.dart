part of 'card_animator.dart';

extension OtherPlayersCardAnimator on CardAnimator {
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
}