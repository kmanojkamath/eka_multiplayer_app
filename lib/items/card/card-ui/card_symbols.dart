import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../card_logic.dart';

import 'symbols/skip_symbol.dart';
import 'symbols/reverse_symbol.dart';
import 'symbols/wild_symbol.dart';

class Symbol extends StatelessWidget {
  final EkaCard _card;
  final bool isMiddleSymbol;
  const Symbol(this._card, {super.key, this.isMiddleSymbol = false});

  @override
  Widget build(BuildContext context) {
    if (_card.isNumber) {
      return Text(
        _card.value.toString(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: isMiddleSymbol ? 81 * 0.4 : 42 * 0.4,
          fontFamily: 'Montserrat',
          fontStyle: isMiddleSymbol ? FontStyle.italic : null,
        ),
      );
    } else if (_card.isDrawTwo) {
      return Text(
        "+2",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: isMiddleSymbol ? 81 * 0.4 : 40 * 0.4,
          fontFamily: 'Montserrat',
          fontStyle: isMiddleSymbol ? FontStyle.italic : null,
        ),
      );
    } else if (_card.isWildDrawFour) {
      return Text(
        "+4",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: isMiddleSymbol ? 81 * 0.4 : 40 * 0.4,
          fontFamily: 'Montserrat',
          fontStyle: isMiddleSymbol ? FontStyle.italic : null,
        ),
      );
    } else if (_card.isSkip) {
      return SizedBox(
        height: isMiddleSymbol ? 72 * 0.4 : 32 * 0.4,
        width: isMiddleSymbol ? 72 * 0.4 : 32 * 0.4,
        child: CustomPaint(painter: SkipSymbol()),
      );
    } else if (_card.isReverse) {
      return SizedBox(
        height: isMiddleSymbol ? 81 * 0.4 : 42 * 0.4,
        width: isMiddleSymbol ? 81 * 0.4 : 42 * 0.4,
        child: CustomPaint(painter: ReverseSymbol()),
      );
    } else if (_card.isWildCard) {
      return SizedBox(
        height: isMiddleSymbol ? 251 * 0.4 : 42 * 0.4,
        width: isMiddleSymbol ? 188 * 0.4 : 42 * 0.81 * 0.4,
        child: CustomPaint(painter: WildSymbol()),
      );
    }

    if (kDebugMode) debugPrint("Card Symbol Error for Card $_card");
    return const Placeholder();
  }
}
