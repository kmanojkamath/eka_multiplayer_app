import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../card/card_animations/positions.dart';
import '../card/card_storage.dart';

class NamePlate extends StatelessWidget {
  final Positions positions;
  final String playerName;
  const NamePlate(this.positions, this.playerName, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: positions.screenSize.width * 0.26,
      height: positions.screenSize.height * 0.10,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
          width: positions.screenSize.width * 0.25,
          height: positions.screenSize.height * 0.09,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                playerName,
                style: TextStyle(
                  fontSize: positions.screenSize.width * 0.022,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
          .collection('room')
          .doc(widget.roomId)
          .collection('players')
          .doc('player${widget.playerNumber}')
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

        final uid = data['player${widget.playerNumber}'];

        if (uid == null) {
          return NamePlate(
            Positions(CardStorage(), MediaQuery.sizeOf(context)),
            "Waiting...",
          );
        }

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get(),
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
              userData['name'] ?? "Unknown Player",
            );
          },
        );
      },
    );
  }
}