import 'package:flutter/material.dart';

enum CardColor { red, green, blue, yellow, wild }

Color color(CardColor cardcolor) {
  switch (cardcolor) {
    case CardColor.red:
      return Colors.red;
    case CardColor.green:
      return Colors.green;
    case CardColor.blue:
      return Colors.blue;
    case CardColor.yellow:
      return Colors.amberAccent;
    case CardColor.wild:
      return Colors.black;
  }
}