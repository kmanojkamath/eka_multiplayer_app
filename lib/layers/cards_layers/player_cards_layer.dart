import 'package:eka_multiplayer_app/widgets/timer.dart';
import 'package:flutter/material.dart';

import '../../game/models/card_storage.dart';
import '../../game/models/positions.dart';

import '../../widgets/card/animated-cards/animated_card.dart';

class PlayerCardsLayer extends StatefulWidget {
  final CardStorage cardStorage;
  const PlayerCardsLayer(this.cardStorage, {super.key});

  @override
  State<PlayerCardsLayer> createState() => _PlayerCardsLayerState();
}

class _PlayerCardsLayerState extends State<PlayerCardsLayer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Stack(
              children: List.generate(108, (i) {
                return AnimatedCard(
                  widget.cardStorage.card[i],
                  widget.cardStorage,
                  cardScale: 0.75,
                  cardWidthScale: 0,
                  cardPosition: Positions(
                    widget.cardStorage,
                    MediaQuery.sizeOf(context),
                  ).drawPosition,
                );
              }),
            ),
            Positioned(
              right: 18,
              bottom: 18,
              child: ListenableBuilder(
                listenable: Listenable.merge([
                  widget.cardStorage.timer,
                  widget.cardStorage.turn,
                ]),
                builder: (_, _) {
                  if (widget.cardStorage.turn.value == 0) {
                    return Timer(progress: widget.cardStorage.timer.value);
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
