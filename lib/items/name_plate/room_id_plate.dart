import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../card/card_animations/positions.dart';

class RoomIdPlate extends StatelessWidget {
  final Positions positions;
  final String roomId;

  const RoomIdPlate(this.positions, this.roomId, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = positions.screenSize.width;
    final screenHeight = positions.screenSize.height;

    return Container(
      width: screenWidth * 0.42,
      height: screenHeight * 0.13,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.03,
                  ),
                  children: [
                    const TextSpan(
                      text: "Room ID: ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: roomId,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: roomId));

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Room ID copied"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.copy_rounded, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
