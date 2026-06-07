import 'package:flutter/material.dart';

import '../../../logics/card_storage.dart';
import '../../../logics/positions.dart';

import '../../../items/card/animated-cards/animated_player_card.dart';
import '../../../items/name_plate/name_plate.dart';

class Player5CardsLayer extends StatefulWidget {
  final CardStorage cardStorage;
  const Player5CardsLayer(this.cardStorage, {super.key});
  @override
  State<Player5CardsLayer> createState() => _Player5CardsLayerState();
}

class _Player5CardsLayerState extends State<Player5CardsLayer> {
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
              top: positions.screenSize.height * 0.63,
              left: 0,
              child: NamePlate(positions, "Player 5"),
            ),
            Stack(
              children: List.generate(widget.cardStorage.player5Card.length, (i) {
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
