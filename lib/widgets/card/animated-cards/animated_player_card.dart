import '../card-ui/back_card_widget.dart';

import 'package:flutter/material.dart';

import 'animated_back_card.dart';

class AnimatedPlayerCard extends StatefulWidget {
  final BackCardController _backCardController;

  final double cardScale;
  final Offset cardPosition;
  final double cardAngle;
  final double cardWidthScale;

  const AnimatedPlayerCard(
    this._backCardController, {
    super.key,
    this.cardScale = 1,
    this.cardPosition = Offset.zero,
    this.cardAngle = 0,
    this.cardWidthScale = 1,
  });

  @override
  State<AnimatedPlayerCard> createState() => _AnimatedPlayerCardState();
}

class _AnimatedPlayerCardState extends State<AnimatedPlayerCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _posController;
  late AnimationController _angleController;
  late AnimationController _widthScaleController;

  late final Listenable _merged;

  late Animation<double> scaleAnim;
  late Animation<Offset> posAnim;
  late Animation<double> angleAnim;
  late Animation<double> widthScaleAnim;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );

    _posController = AnimationController(vsync: this, duration: Duration.zero);

    _angleController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );

    _widthScaleController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );

    _merged = Listenable.merge([
      _scaleController,
      _posController,
      _angleController,
      _widthScaleController,
    ]);

    scaleAnim = AlwaysStoppedAnimation(widget.cardScale);
    posAnim = AlwaysStoppedAnimation(widget.cardPosition);
    angleAnim = AlwaysStoppedAnimation(widget.cardAngle);
    widthScaleAnim = AlwaysStoppedAnimation(widget.cardWidthScale);

    widget._backCardController.changeScale = (newScale, duration, curve) async {
      setState(() {
        _scaleController.duration = duration;

        scaleAnim = Tween<double>(
          begin: scaleAnim.value,
          end: newScale,
        ).animate(CurvedAnimation(parent: _scaleController, curve: curve));
      });

      await _scaleController.forward(from: 0);
    };

    widget._backCardController.changePosition =
        (newPosition, duration, curve) async {
          setState(() {
            _posController.duration = duration;

            posAnim = Tween<Offset>(
              begin: posAnim.value,
              end: newPosition,
            ).animate(CurvedAnimation(parent: _posController, curve: curve));
          });

          await _posController.forward(from: 0);
        };

    widget._backCardController.changeAngle = (newAngle, duration, curve) async {
      setState(() {
        _angleController.duration = duration;

        angleAnim = Tween<double>(
          begin: angleAnim.value,
          end: newAngle,
        ).animate(CurvedAnimation(parent: _angleController, curve: curve));
      });

      await _angleController.forward(from: 0);
    };

    widget
        ._backCardController
        .changeWidthScale = (newWidthScale, duration, curve) async {
      setState(() {
        _widthScaleController.duration = duration;

        widthScaleAnim = Tween<double>(
          begin: widthScaleAnim.value,
          end: newWidthScale,
        ).animate(CurvedAnimation(parent: _widthScaleController, curve: curve));
      });

      await _widthScaleController.forward(from: 0);
    };

    widget._backCardController.changePosition?.call(
      widget.cardPosition,
      Duration(),
      Curves.linear,
    );
  }

  @override
  void dispose() {
    _angleController.dispose();
    _posController.dispose();
    _scaleController.dispose();
    _widthScaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _merged,

      builder: (context, child) {
        return Positioned(
          left: posAnim.value.dx,
          top: posAnim.value.dy,
          child: Transform.rotate(
            angle: angleAnim.value,
            child: Transform.scale(
              scaleX: widthScaleAnim.value * scaleAnim.value,
              scaleY: scaleAnim.value,
              child: child,
            ),
          ),
        );
      },

      child: BackCardWidget(),
    );
  }
}
