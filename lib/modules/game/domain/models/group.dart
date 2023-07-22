import 'package:flutter/material.dart';

import 'game_date.dart';

class Group {
  final String id;
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String local;
  final String image;
  final GameDate date;

  Group({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.local,
    required this.image,
    required this.date,
  });
}
