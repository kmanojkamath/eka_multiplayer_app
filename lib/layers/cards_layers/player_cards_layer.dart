import 'package:flutter/material.dart';

import '../../logics/card_storage.dart';
import '../../logics/positions.dart';

import '../../items/card/animated-cards/animated_card.dart';

class PlayerCardsLayer extends StatefulWidget {
  final CardStorage cardStorage;
  const PlayerCardsLayer(this.cardStorage, {super.key});

  @override
  State<PlayerCardsLayer> createState() => _PlayerCardsLayerState();
}

class _PlayerCardsLayerState extends State<PlayerCardsLayer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            ...List.generate(108, (i) {
              return AnimatedCard(
                widget.cardStorage.card[i],
                widget.cardStorage,
                cardScale: 0.75,
                cardWidthScale: 0,
                cardPosition: Positions(widget.cardStorage, MediaQuery.sizeOf(context)).drawPosition,
              );
            }),
          ],
        );
      },
    );
  }
}
