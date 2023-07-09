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
            Container(color: Colors.grey),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(DateFormat("EEEE (dd/MM)").format(game.date)),
            ),
          ],
        ),
      ),
    );
  }
}
