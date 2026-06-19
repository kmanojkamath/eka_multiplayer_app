import 'package:flutter/material.dart';

import '../../game/models/card_storage.dart';
import '../../game/models/positions.dart';

import '../../widgets/card/animated-cards/animated_back_card.dart';

class DrawCardLayer extends StatefulWidget {
  final CardStorage cardStorage;
  const DrawCardLayer(this.cardStorage, {super.key});

  @override
  State<DrawCardLayer> createState() => _DrawCardsLayerState();
}

class _DrawCardsLayerState extends State<DrawCardLayer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            AnimatedBackCard(
              widget.cardStorage.stationary,
              widget.cardStorage,
              cardScale: 0.5,
              cardPosition: Positions(widget.cardStorage, MediaQuery.sizeOf(context)).drawPosition,
            ),
            AnimatedBackCard(
              widget.cardStorage.backOfDrawingCard,
              widget.cardStorage,
              cardScale: 0.5,
              cardPosition: Positions(widget.cardStorage, MediaQuery.sizeOf(context)).drawPosition,
            ),
          ],
        );
      },
    );
  }
}
