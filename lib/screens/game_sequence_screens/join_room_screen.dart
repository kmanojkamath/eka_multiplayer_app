import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/widgets/name_plate/join_room_plate.dart';
import 'package:eka_multiplayer_app/game/models/game_log.dart';
import 'package:eka_multiplayer_app/screens/game_sequence_screens/game_initialiser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../game/models/positions.dart';
import '../../game/models/card_storage.dart';

import '../../widgets/name_plate/room_id_plate.dart';
import '../../widgets/name_plate/room_name_plate.dart';

import '../../layers/background.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  String roomId = "";
  bool joined = false;
  int playerNumber = -1;

  Future<void> waitForGameStart() async {
    final snap = await FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('logs')
        .doc('0')
        .snapshots()
        .firstWhere((snap) => snap.exists);

    final log = snap.toGameLog() as GameInitializationLog;

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => GameInitialiser(
          playerCount: log.playerCount,
          startingPlayer: log.startingPlayer,
          playerNumber: playerNumber,
          roomId: roomId,
        ),
      ),
    );
  }

  Future<void> onJoin(String roomId) async {
    final roomRef = FirebaseFirestore.instance.collection('rooms').doc(roomId);

    final roomDoc = await roomRef.get();

    if (!roomDoc.exists) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Room not found')));
      }
      return;
    }

    final data = roomDoc.data()!;

    final players = List.from(data['players'] ?? []);

    if (players.length >= 6) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Room is full')));
      }
      return;
    }

    final logsSnapshot = await roomRef.collection('logs').limit(1).get();

    if (logsSnapshot.docs.isNotEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Game already started')));
      }
      return;
    }

    playerNumber = players.length;

    await roomRef.update({
      'players': FieldValue.arrayUnion([
        FirebaseAuth.instance.currentUser!.uid,
      ]),
    });

    setState(() {
      this.roomId = roomId;
      joined = true;
    });

    await waitForGameStart();
  }

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
                if (joined)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoomNamePlate(playerNumber: 0, roomId: roomId),
                      RoomNamePlate(playerNumber: 1, roomId: roomId),
                      RoomNamePlate(playerNumber: 2, roomId: roomId),
                    ],
                  ),
                if (joined) const Spacer(),
                if (joined)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoomNamePlate(playerNumber: 3, roomId: roomId),
                      RoomNamePlate(playerNumber: 4, roomId: roomId),
                      RoomNamePlate(playerNumber: 5, roomId: roomId),
                    ],
                  ),
                const Spacer(),
                joined
                    ? RoomIdPlate(
                        Positions(CardStorage(0), MediaQuery.of(context).size),
                        roomId,
                      )
                    : Center(
                        child: JoinRoomPlate(
                          positions: Positions(
                            CardStorage(0),
                            MediaQuery.of(context).size,
                          ),
                          onJoin: onJoin,
                        ),
                      ),
                const Spacer(),
                if (joined)
                  Row(
                    children: [
                      const Spacer(flex: 5),
                      const CircularProgressIndicator(),
                      const Spacer(),
                      Text(
                        'Waiting for host to start the game...',
                        style: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).height * 0.067,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(flex: 5),
                    ],
                  ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
