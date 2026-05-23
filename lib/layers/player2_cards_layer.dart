import 'package:eka_multiplayer_app/items/card/card_animations/positions.dart';
import 'package:eka_multiplayer_app/items/card/card_storage.dart';
import 'package:eka_multiplayer_app/items/card/animated-cards/animated_player_card.dart';

import 'package:flutter/material.dart';

import '../items/name_plate/name_plate.dart';

class Player2CardsLayer extends StatefulWidget {
  final CardStorage cardStorage;
  const Player2CardsLayer(this.cardStorage, {super.key});
  @override
  State<Player2CardsLayer> createState() => _Player2CardsLayerState();
}

class _Player2CardsLayerState extends State<Player2CardsLayer> {
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
              top: positions.screenSize.height * 0.184,
              left: positions.screenSize.width * 0.37,
              child: NamePlate(positions, "Player 2"),
            ),
            Stack(
              children: List.generate(widget.cardStorage.player2Card.length, (
                i,
              ) {
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
