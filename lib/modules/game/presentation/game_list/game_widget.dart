import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/game.dart';

class GameWidget extends StatelessWidget {
  final Game game;
  final void Function(Game) onClick;

  const GameWidget({Key? key, required this.game, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick.call(game);
      },
      child: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(32.0),
                shape: BoxShape.rectangle,
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
            //Align(alignment: Alignment.center,)
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/football-field.png", width: 100, height: 100,),
                  Text(DateFormat("EEEE (dd/MM)").format(game.date))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
