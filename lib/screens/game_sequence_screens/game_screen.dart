import 'package:eka_multiplayer_app/items/card/card_animations/positions.dart';
import 'package:eka_multiplayer_app/layers/cards_layers/other_player_cards_layers/player3_cards_layer.dart';
import 'package:eka_multiplayer_app/layers/cards_layers/other_player_cards_layers/player4_cards_layer.dart';
import 'package:eka_multiplayer_app/layers/cards_layers/other_player_cards_layers/player5_cards_layer.dart';
import 'package:eka_multiplayer_app/layers/cards_layers/other_player_cards_layers/player6_cards_layer.dart';

import '/items/card/card_animations/card_animations.dart';
import '/items/card/card_storage.dart';


import '/layers/background.dart';
import '../../layers/cards_layers/other_player_cards_layers/player2_cards_layer.dart';
import '../../layers/cards_layers/draw_card_layer.dart';
import '../../layers/cards_layers/top_card.dart';
import '/layers/color_selector.dart';
import '../../layers/cards_layers/player_cards_layer.dart';


import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  CardStorage cardStorage = CardStorage();
  CardAnimations cardAnimations = CardAnimations(
    CardStorage(),
    Positions(CardStorage(), Size(0, 0)),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cardAnimations = CardAnimations(
        cardStorage,
        Positions(cardStorage, MediaQuery.sizeOf(context)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Background(),
            TopCard(cardStorage),
            Player2CardsLayer(cardStorage),
            Player3CardsLayer(cardStorage),
            Player4CardsLayer(cardStorage),
            Player5CardsLayer(cardStorage),
            Player6CardsLayer(cardStorage),
            DrawCardLayer(cardStorage),
            ColorSelector(cardStorage),
            PlayerCardsLayer(cardStorage),
          ],
        ),
      ),
    );
  }
}
