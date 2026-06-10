import 'package:eka_multiplayer_app/items/name_plate/room_name_plate.dart';
import 'package:eka_multiplayer_app/logics/ui_player_number.dart';
import 'package:flutter/material.dart';

import '../../items/card/animated-cards/animated_player_card.dart';

import '../../logics/card_storage.dart';
import '../../logics/positions.dart';

class PlayerNCardsLayer extends StatefulWidget {
  final CardStorage cardStorage;
  final int uiPlayerNumber;
  final String roomId;
  const PlayerNCardsLayer(
    this.cardStorage, {
    super.key,
    required this.uiPlayerNumber,
    required this.roomId,
  });
  @override
  State<PlayerNCardsLayer> createState() => _PlayerNCardsLayerState();
}

class _PlayerNCardsLayerState extends State<PlayerNCardsLayer> {
  @override
  Widget build(BuildContext context) {
    Positions positions = Positions(
      widget.cardStorage,
      MediaQuery.sizeOf(context),
    );
    const top = [0.184, 0.305, 0.3, 0.63, 0.63];
    const left = [0.37, 0.11, 0.63, 0, 0.74];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              top: positions.screenSize.height * top[widget.uiPlayerNumber - 1],
              left:
                  positions.screenSize.width * left[widget.uiPlayerNumber - 1],
              child: RoomNamePlate(
                playerNumber: realPlayerNumber(
                  widget.cardStorage.playerCount,
                  widget.uiPlayerNumber,
                ),
                roomId: widget.roomId,
              ),
            ),
            Stack(
              children: List.generate(
                widget.cardStorage.playerNCard(widget.uiPlayerNumber).length,
                (i) {
                  return AnimatedPlayerCard(
                    widget.cardStorage.playerNCard(widget.uiPlayerNumber)[i],
                    cardScale: positions.drawScale,
                    cardWidthScale: 0,
                    cardPosition: positions.drawPosition,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
