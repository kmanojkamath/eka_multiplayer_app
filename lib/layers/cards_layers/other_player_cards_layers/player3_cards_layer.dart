import 'package:flutter/material.dart';

import '../../../logics/card_storage.dart';
import '../../../logics/positions.dart';

import '../../../items/card/animated-cards/animated_player_card.dart';
import '../../../items/name_plate/name_plate.dart';

class Player3CardsLayer extends StatefulWidget {
  final CardStorage cardStorage;
  const Player3CardsLayer(this.cardStorage, {super.key});
  @override
  State<Player3CardsLayer> createState() => _Player3CardsLayerState();
}

class _Player3CardsLayerState extends State<Player3CardsLayer> {
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
              top: positions.screenSize.height * 0.305,
              left: positions.screenSize.width * 0.11,
              child: NamePlate(positions, "Player 3"),
            ),
            Stack(
              children: List.generate(widget.cardStorage.player3Card.length, (i) {
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
