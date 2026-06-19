import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/game/models/game_log.dart';
import 'package:flutter/foundation.dart';

import '../../animations/card_animations/card_animations.dart';

import '../models/card_logic.dart';
import '../models/card_storage.dart';
import '../models/move.dart';

import '../../helpers/colors.dart';

part 'helpers/getters_setters.dart';
part 'helpers/functions.dart';
part 'helpers/log_helpers.dart';
part 'helpers/waiters.dart';

part 'actions/game_start.dart';
part 'actions/player_turn.dart';
part 'actions/process_log.dart';

class HostGamePlay {
  final CardAnimations _cardAnimations;
  final DocumentReference _roomRef;
  final int startingPlayer;

  const HostGamePlay(
    this._cardAnimations,
    this._roomRef, {
    required this.startingPlayer,
  });
}
