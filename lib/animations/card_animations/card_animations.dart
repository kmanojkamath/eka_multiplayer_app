import 'package:flutter/material.dart';

import '../../items/card/animated-cards/animated_back_card.dart';
import '../../logics/card_storage.dart';

import '../../logics/positions.dart';

import '../card_animators/card_animator.dart';

part 'draw_card_animations.dart';
part 'play_card_animations.dart';
part 'top_card_animations.dart';
part 'playable_card_animations.dart';

class CardAnimations {
  final CardStorage cardStorage;
  final CardAnimator cardAnimator;
  final Positions positions;

  CardAnimations(this.cardStorage, this.positions)
    : cardAnimator = CardAnimator(cardStorage);
}
