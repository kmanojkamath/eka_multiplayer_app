import 'package:eka_multiplayer_app/items/card/card_animations/positions.dart';
import 'package:eka_multiplayer_app/items/card/card_storage.dart';
import 'package:eka_multiplayer_app/items/card/animated-cards/animated_player_card.dart';

import 'package:flutter/material.dart';

import '../items/name_plate/name_plate.dart';

class Player4CardsLayer extends StatefulWidget {
  final CardStorage cardStorage;
  const Player4CardsLayer(this.cardStorage, {super.key});
  @override
  State<Player4CardsLayer> createState() => _Player4CardsLayerState();
}

class _Player4CardsLayerState extends State<Player4CardsLayer> {
  @override
  Widget build(BuildContext context) {
    Positions positions = Positions(
      widget.cardStorage,
      MediaQuery.sizeOf(context),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              top: positions.screenSize.height * 0.3,
              left: positions.screenSize.width * 0.63,
              child: NamePlate(positions, "Player 4"),
            ),
            Stack(
              children: List.generate(widget.cardStorage.player4Card.length, (i) {
                return AnimatedPlayerCard(
                  widget.cardStorage.player2Card[i],
                  cardScale: positions.drawScale,
                  cardWidthScale: 0,
                  cardPosition: positions.drawPosition,
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
