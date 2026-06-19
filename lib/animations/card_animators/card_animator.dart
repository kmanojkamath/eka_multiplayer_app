import 'package:flutter/material.dart';

import '../../widgets/card/animated-cards/animated_back_card.dart';
import '../../game/models/card_storage.dart';

part 'player_card_animator.dart';
part 'back_card_animator.dart';
part 'other_players_card_animator.dart';
part 'top_card_animator.dart';

class CardAnimator {
  final CardStorage cardStorage;

  const CardAnimator(this.cardStorage);
}
