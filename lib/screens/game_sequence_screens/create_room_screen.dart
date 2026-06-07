import 'package:flutter/material.dart';

import '../../items/card/card_animations/positions.dart';
import '../../items/card/card_storage.dart';
import '../../items/name_plate/room_id_plate.dart';
import '../../items/name_plate/room_name_plate.dart';
import '../../items/start_game_button/start_game_button.dart';

import '../../layers/background.dart';

class CreateRoomScreen extends StatefulWidget {
  final String roomId;
  const CreateRoomScreen(this.roomId, {super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            const Background(),
            Column(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoomNamePlate(playerNumber: 1, roomId: widget.roomId),
                    RoomNamePlate(playerNumber: 2, roomId: widget.roomId),
                    RoomNamePlate(playerNumber: 3, roomId: widget.roomId),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoomNamePlate(playerNumber: 4, roomId: widget.roomId),
                    RoomNamePlate(playerNumber: 5, roomId: widget.roomId),
                    RoomNamePlate(playerNumber: 6, roomId: widget.roomId),
                  ],
                ),
                const Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoomIdPlate(
                      Positions(CardStorage(), MediaQuery.of(context).size),
                      widget.roomId,
                    ),
                    LiveStartGameButton(roomId: widget.roomId),
                  ],
                ),
                const Spacer(flex: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}