import 'package:eka_multiplayer_app/items/card/card_animations/positions.dart';
import 'package:eka_multiplayer_app/items/card/card_storage.dart';
import 'package:flutter/material.dart';

import '../items/card/animated-cards/animated_card.dart';

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
            ...List.generate(widget.cardStorage.playerPile.length, (i) {
              return AnimatedCard(
                widget.cardStorage.card[i],
                widget.cardStorage,
                cardScale: Positions(widget.cardStorage, MediaQuery.sizeOf(context)).playerCardScale,
                cardWidthScale: 1,
                cardPosition: Positions(widget.cardStorage, MediaQuery.sizeOf(context)).playerCardPosition(i),
                cardAngle: Positions(widget.cardStorage, MediaQuery.sizeOf(context)).playerCardAngle(i),
              );
            }),
          ],
        );
      },
    );
  }
}
