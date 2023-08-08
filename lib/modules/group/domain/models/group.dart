import 'package:flutter/material.dart';

import '../../../match/domain/models/game_date.dart';

class Group {
  final String id;
  final String userId;
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String local;
  final String image;
  final GameDate date;

  Group({
    required this.id,
    required this.userId,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.local,
    required this.image,
    required this.date,
  });
}
