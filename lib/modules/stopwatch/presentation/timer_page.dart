import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_randomizer/modules/stopwatch/presentation/timer_text.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Stopwatch stopwatch = Stopwatch();

  void leftButtonPressed() {
    setState(() {
      if (stopwatch.isRunning) {
        print("${stopwatch.elapsedMilliseconds}");
      } else {
        stopwatch.reset();
      }
    });
  }

  void rightButtonPressed() {
    setState(() {
      if (stopwatch.isRunning) {
        stopwatch.stop();
      } else {
        stopwatch.start();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Center(
              child: TimerText(stopwatch: stopwatch),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(onPressed: () {
                leftButtonPressed();
              }, child: (stopwatch.isRunning) ? Text("Lap") : Text("Reset"),),
              FloatingActionButton(onPressed: () {
                rightButtonPressed();
              }, child: (stopwatch.isRunning) ? Text("Stop") : Text("Start"),)
            ],
          ),
        ],
      ),
    ));
  }
}
