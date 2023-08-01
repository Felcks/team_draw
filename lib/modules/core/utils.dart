import 'package:flutter/material.dart';

String TimeOfDayToString(TimeOfDay time) {
  String addLeadingZeroIfNeeded(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  final String hourLabel = addLeadingZeroIfNeeded(time.hour);
  final String minuteLabel = addLeadingZeroIfNeeded(time.minute);

  return '$hourLabel:$minuteLabel';
}

bool isTablet(BuildContext context) {
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  return shortestSide > 600;
}