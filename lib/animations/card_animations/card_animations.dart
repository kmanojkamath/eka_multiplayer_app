import 'package:flutter/material.dart';

import '../../widgets/card/animated-cards/animated_back_card.dart';

import '../../game/models/positions.dart';

import '../card_animators/card_animator.dart';

part 'draw_card_animations.dart';
part 'play_card_animations.dart';
part 'top_card_animations.dart';
part 'playable_card_animations.dart';

class CardAnimations {
  final CardAnimator cardAnimator;
  final Positions positions;

  CardAnimations(this.positions)
    : cardAnimator = CardAnimator(positions.cardStorage);
}
