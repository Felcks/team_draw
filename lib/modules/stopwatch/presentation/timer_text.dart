import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:team_randomizer/modules/stopwatch/presentation/timer_text_formatter.dart';

class TimerText extends StatefulWidget {
  TimerText({required this.stopwatch});
  final Stopwatch stopwatch;

  TimerTextState createState() => TimerTextState(stopwatch: stopwatch);
}

class TimerTextState extends State<TimerText> {

  late Timer timer;
  final Stopwatch stopwatch;


  TimerTextState({required this.stopwatch}) {
    timer = Timer.periodic(const Duration(milliseconds: 30), callback);
  }

  void callback(Timer timer) {
    if (stopwatch.isRunning) {
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle timerTextStyle = TextStyle(fontSize: 60.0, fontFamily: "Open Sans");
    String formattedTime = TimerTextFormatter.format(stopwatch.elapsedMilliseconds);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: SizedBox(width: 80, child: Text(formattedTime.substring(0,2), style: timerTextStyle,))),
        Flexible(child: Text(":", style: timerTextStyle,)),
        Flexible(child: SizedBox(width: 80, child: Text(formattedTime.substring(3,5), style: timerTextStyle,))),
        Flexible(child: Text(".", style: timerTextStyle,)),
        Flexible(child: SizedBox(width:80, child: Text(formattedTime.substring(6), style: timerTextStyle,)))
      ],
    );
  }
}