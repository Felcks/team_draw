import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/game/domain/models/player.dart';

import 'game_date.dart';

class Group {
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String local;
  final String image;
  final List<Player> players;
  final GameDate date;

  Group({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.local,
    required this.image,
    required this.players,
    required this.date,
  });
}
