import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/game/domain/models/game.dart';
import 'package:team_randomizer/modules/game/domain/models/game_player.dart';

import '../../../stopwatch/presentation/timer_page.dart';
import '../../../team_draw/presentation/team_draw_page.dart';
import '../group_home/new_player_widget.dart';

class GameHomePage extends StatefulWidget {

  final Game game;
  const GameHomePage({Key? key, required this.game}) : super(key: key);

  @override
  State<GameHomePage> createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Jogadores'),
          BottomNavigationBarItem(icon: Icon(Icons.abc_outlined), label: 'Times'),
          BottomNavigationBarItem(icon: Icon(Icons.hourglass_bottom), label: 'Cronometro'),
        ],
      ),
      body: (_selectedIndex == 0) ? playersListWidget() : (_selectedIndex == 1) ? TeamDrawPage(game: widget.game) : TimerPage(),
    );

    return Scaffold(
      body: SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: playersListWidget())),
    );
  }

  Widget playersListWidget() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text(
                    "Jogadores",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.game.players.length,
                itemBuilder: (context, index) {
                  GamePlayer gamePlayer = widget.game.players[index];
                  return SizedBox(
                    height: 85,
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Align(alignment: Alignment.topCenter, child: SizedBox(height: 85, child: NewPlayerWidget(player: gamePlayer.player))),
                        Positioned(left: 20, top: 50, child: Text("(${gamePlayer.status.value})", style: TextStyle(fontSize: 12),),)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
