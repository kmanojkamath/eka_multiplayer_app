import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String winnerName;
  final bool didWin;
  const ResultScreen({super.key, required this.winnerName, required this.didWin});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            colors: [
              didWin ? Colors.lightGreen : Colors.red,
              didWin ? Colors.green[900]! : Colors.brown,
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 5),
            Text(
              "$winnerName Wins",
              style: TextStyle(fontSize: 69, fontWeight: FontWeight.w900),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}