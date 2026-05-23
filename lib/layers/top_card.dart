import 'package:eka_multiplayer_app/items/card/card-ui/card_widget.dart';
import 'package:eka_multiplayer_app/items/card/card_logic.dart';
import 'package:eka_multiplayer_app/items/card/card_storage.dart';
import 'package:eka_multiplayer_app/items/card/card_animations/positions.dart';
import 'package:flutter/material.dart';

class TopCard extends StatefulWidget {
  final CardStorage cardStorage;

  const TopCard(this.cardStorage, {super.key});

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Positions positions = Positions(
      widget.cardStorage,
      MediaQuery.sizeOf(context),
    );
    return Stack(
      children: [
        Positioned(
          left: positions.topCardPosition.dx,
          top: positions.topCardPosition.dy,
          child: Transform.scale(
            scale: positions.topCardScale,
            child: ValueListenableBuilder<EkaCard>(
              valueListenable: widget.cardStorage.displayedTopCard,
              builder: (context, value, child) =>
                  value.ci >= 0 ? EkaCardWidget(value) : SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}
