import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/game/domain/models/game.dart';
import 'package:team_randomizer/modules/game/domain/models/game_player.dart';
import 'package:team_randomizer/modules/game/domain/models/game_player_status.dart';

import '../../../stopwatch/presentation/timer_page.dart';
import '../../../team_draw/presentation/team_draw_page.dart';
import '../../domain/models/player.dart';
import '../group_home/new_player_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class GameHomePage extends StatefulWidget {

  final Game game;
  const GameHomePage({Key? key, required this.game}) : super(key: key);

  @override
  State<GameHomePage> createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage> {

  int _selectedIndex = 0;

  List<GamePlayer> _players = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    final FirebaseApp _app = Firebase.app();
    FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: _app,
      databaseURL: "https://team-randomizer-1516f-default-rtdb.europe-west1.firebasedatabase.app/",
    );

    //GET PLAYERS FROM player and filter
    database
        .ref("player")
        .onValue
        .listen((event) async {
      List<DataSnapshot> databasePlayersOnThisGroup = event.snapshot.children.where((element) {
        Map<Object?, Object?> playerMap = element.value as Map<Object?, Object?>;
        return playerMap["groupId"] == widget.game.groupId;
      }).toList(growable: true);

      List<Player> result = List.empty(growable: true);
      databasePlayersOnThisGroup.forEach((element) {
        Map<Object?, Object?> player = (element.value as Map<Object?, Object?>);
        result.add(
          Player(
            groupId: (player["groupId"] as String),
            id: element.key.toString(),
            name: (player["name"] as String),
            overall: (player["overall"] as int),
          ),
        );
      });


        DataSnapshot gamePlayer = await database.ref("game_player").get();
        List<DataSnapshot> gamePlayersOnThisGame = gamePlayer.children.where((element) {
          Map<Object?, Object?> gamePlayerMap = element.value as Map<Object?, Object?>;
          return gamePlayerMap["gameId"] == widget.game.id;
        }).toList(growable: true);

        List<GamePlayer> gamePlayers = result.map((player) {
          DataSnapshot gamePlayerSnapshot = gamePlayersOnThisGame.firstWhere((element) => (element.value as Map<Object?, Object?>)["playerId"] == player.id);

          /*String gamePlayerDatabase = gamePlayersOnThisGame.firstWhere((element) => ((element.value as Map<Object?, Object?>)["playerId"] == player.id).value as (element as Map<Object?, Object?>)["status"]*/
          GamePlayerStatus status = GamePlayerStatus.values.firstWhere((element) => element.name == (gamePlayerSnapshot.value as Map<Object?, Object?>)["status"], orElse: () => GamePlayerStatus.NOT_CONFIRMED);

          return GamePlayer(player: player, status: status);
        }).toList();

      setState(() {
        _players = gamePlayers;
      });

      /**/
    });
  }

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
                itemCount: _players.length,
                itemBuilder: (context, index) {
                  GamePlayer gamePlayer = _players[index];
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
