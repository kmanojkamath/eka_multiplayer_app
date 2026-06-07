import 'dart:async';

import 'package:flutter/material.dart';

import '../../../logics/card_storage.dart';
import '../../../logics/card_logic.dart';

import '../card-ui/card_widget.dart';

class CardController {
  Future<void> Function(double, Duration, Curve)? changeScale;
  Future<void> Function(Offset, Duration, Curve)? changePosition;
  Future<void> Function(double, Duration, Curve)? changeAngle;
  Future<void> Function(double, Duration, Curve)? changeWidthScale;
  bool locked = true;
}

class AnimatedCard extends StatefulWidget {
  final EkaCard _card;

  final CardStorage cardStorage;

  final double cardScale;
  final Offset cardPosition;
  final double cardAngle;
  final double cardWidthScale;

  const AnimatedCard(
    this._card,
    this.cardStorage, {
    super.key,
    this.cardScale = 1,
    this.cardPosition = Offset.zero,
    this.cardAngle = 0,
    this.cardWidthScale = 1,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
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

    widget._card.controller.changeScale = (newScale, duration, curve) async {
      setState(() {
        _scaleController.duration = duration;

        scaleAnim = Tween<double>(
          begin: scaleAnim.value,
          end: newScale,
        ).animate(CurvedAnimation(parent: _scaleController, curve: curve));
      });

      await _scaleController.forward(from: 0);
    };

    widget._card.controller.changePosition =
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

    widget._card.controller.changeAngle = (newAngle, duration, curve) async {
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
        ._card
        .controller
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
      child: GestureDetector(
        onTap: () {
          debugPrint("Tapped on card ${widget._card.ci}");
          if (widget._card.controller.locked == false) {
            widget.cardStorage.selectedCard.value = widget._card.ci;
            for (var element in widget.cardStorage.card) {
              element.controller.locked = true;
            }
          }
        },
        child: EkaCardWidget(widget._card),
      ),
    );
  }
}
