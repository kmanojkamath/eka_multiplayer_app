import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../logics/name_generator.dart';
import '../card/card_animations/positions.dart';
import '../card/card_storage.dart';
import 'name_plate.dart';

class RoomNamePlate extends StatefulWidget {
  final int playerNumber;
  final String roomId;

  const RoomNamePlate({
    super.key,
    required this.playerNumber,
    required this.roomId,
  });

  @override
  State<RoomNamePlate> createState() => _RoomNamePlateState();
}

class _RoomNamePlateState extends State<RoomNamePlate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('rooms')
          .doc(widget.roomId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final doc = snapshot.data!;

        if (!doc.exists) {
          return NamePlate(
            Positions(CardStorage(), MediaQuery.sizeOf(context)),
            "Waiting...",
          );
        }

        final data = doc.data() as Map<String, dynamic>;

        List<String> players = List<String>.from(data['players'] ?? []);

        if (players.length < widget.playerNumber) {
          return NamePlate(
            Positions(CardStorage(), MediaQuery.sizeOf(context)),
            "Waiting...",
          );
        }

        String uid = players[widget.playerNumber - 1];

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (context, userSnapshot) {
            if (!userSnapshot.hasData) {
              return NamePlate(
                Positions(CardStorage(), MediaQuery.sizeOf(context)),
                "Loading...",
              );
            }

            final userDoc = userSnapshot.data!;

            if (!userDoc.exists) {
              return NamePlate(
                Positions(CardStorage(), MediaQuery.sizeOf(context)),
                "Unknown Player",
              );
            }

            final userData = userDoc.data() as Map<String, dynamic>;

            return NamePlate(
              Positions(CardStorage(), MediaQuery.sizeOf(context)),
              getNameFromNumber(userData['name']),
            );
          },
        );
      },
    );
  }
}