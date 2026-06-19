import 'package:eka_multiplayer_app/items/name_plate/room_name_plate.dart';
import 'package:eka_multiplayer_app/logics/ui_player_number.dart';
import 'package:flutter/material.dart';

import '../../items/card/animated-cards/animated_player_card.dart';

import '../../logics/card_storage.dart';
import '../../logics/positions.dart';

class PlayerNCardsLayer extends StatefulWidget {
  final CardStorage cardStorage;
  final int playerCount;
  final int playerNumber;
  final int currentPlayer;
  final String roomId;
  const PlayerNCardsLayer(
    this.cardStorage, {
    super.key,
    required this.playerCount,
    required this.playerNumber,
    required this.currentPlayer,
    required this.roomId,
  });
  @override
  State<PlayerNCardsLayer> createState() => _PlayerNCardsLayerState();
}

class _PlayerNCardsLayerState extends State<PlayerNCardsLayer> {
  int localPlayerNumber(int playerNumber) {
    return (widget.playerCount + playerNumber - widget.currentPlayer) %
        widget.playerCount;
  }

  @override
  Widget build(BuildContext context) {
    Positions positions = Positions(
      widget.cardStorage,
      MediaQuery.sizeOf(context),
    );
    const top = [0.63, 0.305, 0.184, 0.3, 0.63];
    const left = [0, 0.11, 0.37, 0.63, 0.74];
    return LayoutBuilder(
      builder: (context, constraints) {
        final uiPN = uiPlayerNumber(widget.playerCount, widget.playerNumber);
        return Stack(
          children: [
            Positioned(
              top: positions.screenSize.height * top[uiPN],
              left: positions.screenSize.width * left[uiPN],
              child: RoomNamePlate(
                playerNumber: localPlayerNumber(widget.playerNumber),
                roomId: widget.roomId,
              ),
            ),
            Stack(
              children: List.generate(
                widget.cardStorage.playerNCard(widget.playerNumber).length,
                (i) {
                  return AnimatedPlayerCard(
                    widget.cardStorage.playerNCard(widget.playerNumber)[i],
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
