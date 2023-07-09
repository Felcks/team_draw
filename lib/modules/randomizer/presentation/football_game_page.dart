import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_randomizer/modules/randomizer/presentation/player_widget.dart';

import '../../game/domain/models/player.dart';

class FootballGamePage extends StatefulWidget {
  const FootballGamePage({Key? key}) : super(key: key);

  @override
  State<FootballGamePage> createState() => _FootballGamePageState();
}
class _FootballGamePageState extends State<FootballGamePage> {
  List<Player> players = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _playerColumn(),
      floatingActionButton: FloatingActionButton.large(
          onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
  
  Widget _playerColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) {
              Player player = players[index];
              return PlayerWidget(
                player: player,
                position: index + 1,
                changeStarCallback: (callbackPlayer) {
                  players[index] = callbackPlayer;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
