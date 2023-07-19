import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/core/data/database_utils.dart';
import 'package:team_randomizer/modules/game/domain/models/game.dart';
import 'package:team_randomizer/modules/game/domain/models/game_player.dart';
import 'package:team_randomizer/modules/game/domain/models/game_player_status.dart';

import '../../../stopwatch/presentation/timer_page.dart';
import '../../../team_draw/presentation/team_draw_page.dart';
import '../../domain/models/player.dart';
import '../group_home/new_player_widget.dart';
import 'package:firebase_database/firebase_database.dart';

class GameHomePage extends StatefulWidget {
  final Game game;

  const GameHomePage({Key? key, required this.game}) : super(key: key);

  @override
  State<GameHomePage> createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage> {
  int _selectedIndex = 0;

  List<GamePlayer> _players = List.empty(growable: true);
  FirebaseDatabase database = getDatabase();
  bool _listenToGamePlayersUpdate = false;

  void listenToPlayersUpdate() {
    database.ref("player").onValue.listen((allPlayers) async {
      List<DataSnapshot> playersOnThisGroupSnapshot = allPlayers.snapshot.children.where((element) {
        Map<Object?, Object?> playerMap = element.value as Map<Object?, Object?>;
        return playerMap["groupId"] == widget.game.groupId;
      }).toList(growable: true);

      List<Player> players = List.empty(growable: true);
      playersOnThisGroupSnapshot.forEach((element) {
        Map<Object?, Object?> player = (element.value as Map<Object?, Object?>);
        players.add(
          Player(
            groupId: (player["groupId"] as String),
            id: element.key.toString(),
            name: (player["name"] as String),
            overall: (player["overall"] as int),
          ),
        );
      });

      if (!_listenToGamePlayersUpdate) {
        _listenToGamePlayersUpdate = true;
        _players = players.map((e) => GamePlayer(id: "", player: e, status: GamePlayerStatus.NOT_CONFIRMED)).toList();
        listenToGamePlayersUpdate();
      }
    });
  }

  /*
  void updatePlayersStatus(List<Player> players) async {
    DataSnapshot gamePlayerSnapshot = await database.ref("game_player").get();
    List<DataSnapshot> gamePlayersOnThisGame = gamePlayerSnapshot.children.where((element) {
      Map<Object?, Object?> gamePlayerMap = element.value as Map<Object?, Object?>;
      return gamePlayerMap["gameId"] == widget.game.id;
    }).toList(growable: true);

    List<GamePlayer> gamePlayers = players.map((player) {
      DataSnapshot gamePlayerSnapshot = gamePlayersOnThisGame
          .firstWhere((element) => (element.value as Map<Object?, Object?>)["playerId"] == player.id);

      GamePlayerStatus status = GamePlayerStatus.values.firstWhere(
              (element) => element.name == (gamePlayerSnapshot.value as Map<Object?, Object?>)["status"],
          orElse: () => GamePlayerStatus.NOT_CONFIRMED);

      return GamePlayer(player: player, status: status);
    }).toList();

    setState(() {
      _players = gamePlayers;
    });
  }*/

  void listenToGamePlayersUpdate() {
    database.ref("game_player").onValue.listen((allGamePlayers) async {
      DataSnapshot gamePlayerSnapshot = allGamePlayers.snapshot;
      List<DataSnapshot> gamePlayersOnThisGame = gamePlayerSnapshot.children.where((element) {
        Map<Object?, Object?> gamePlayerMap = element.value as Map<Object?, Object?>;
        return gamePlayerMap["gameId"] == widget.game.id;
      }).toList(growable: true);

      List<GamePlayer> playersWithStatusUpdated = _players.map((player) {
        bool gamePlayerNotFound = false;
        DataSnapshot gamePlayerSnapshot = gamePlayersOnThisGame.firstWhere(
            (element) => (element.value as Map<Object?, Object?>)["playerId"] == player.player.id, orElse: () {
          gamePlayerNotFound = true;
          return gamePlayersOnThisGame.first;
        });

        if(gamePlayerNotFound) {
          DatabaseReference ref = getDatabase().ref();
          print(player.player.id);
          ref.child("game_player").push().set({
            "playerId": player.player.id,
            "gameId": widget.game.id,
            "status": "NOT_CONFIRMED"
          });

          return GamePlayer(id: "", player: player.player, status: GamePlayerStatus.NOT_CONFIRMED);
        }

        GamePlayerStatus status = GamePlayerStatus.values.firstWhere(
            (element) => element.name == (gamePlayerSnapshot.value as Map<Object?, Object?>)["status"],
            orElse: () => GamePlayerStatus.NOT_CONFIRMED);

        return GamePlayer(id: gamePlayerSnapshot.key ?? "", player: player.player, status: status);
      }).toList();

      setState(() {
        _players = playersWithStatusUpdated;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    listenToPlayersUpdate();
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
      body: (_selectedIndex == 0)
          ? playersListWidget()
          : (_selectedIndex == 1)
              ? TeamDrawPage(game: widget.game)
              : TimerPage(),
    );

    return Scaffold(
      body: SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: playersListWidget())),
    );
  }

  Widget playersListWidget() {
    GamePlayerStatus selectedGamePlayerStatus = GamePlayerStatus.NOT_CONFIRMED;
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
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: 85,
                            child: NewPlayerWidget(player: gamePlayer.player),
                          ),
                        ),
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(8.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(width: 2, color: getPlayerStatusColor(gamePlayer)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 120,
                          top: 40,
                          child: PopupMenuButton<GamePlayerStatus>(
                            initialValue: selectedGamePlayerStatus,
                            // Callback that sets the selected popup menu item.
                            onSelected: (GamePlayerStatus item) {
                              setState(() {
                                selectedGamePlayerStatus = item;
                                DatabaseReference ref = getDatabase().ref();
                                ref.child("game_player/${gamePlayer.id}").update({"status": item.name});
                              });
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<GamePlayerStatus>>[
                              const PopupMenuItem<GamePlayerStatus>(
                                value: GamePlayerStatus.NOT_CONFIRMED,
                                child: Text('Não Confirmado'),
                              ),
                              const PopupMenuItem<GamePlayerStatus>(
                                value: GamePlayerStatus.CANCELLED,
                                child: Text('Cancelado'),
                              ),
                              const PopupMenuItem<GamePlayerStatus>(
                                value: GamePlayerStatus.CONFIRMED,
                                child: Text('Confirmado'),
                              ),
                              const PopupMenuItem<GamePlayerStatus>(
                                value: GamePlayerStatus.READY,
                                child: Text('Pronto'),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 15,
                          top: 55,
                          child: Text(
                            "(${gamePlayer.status.value})",
                            style: TextStyle(fontSize: 12),
                          ),
                        )
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

  Color getPlayerStatusColor(GamePlayer player) {
    switch (player.status) {
      case GamePlayerStatus.CANCELLED:
        return Colors.red.withOpacity(.5);
      case GamePlayerStatus.NOT_CONFIRMED:
        return Colors.amber.withOpacity(.5);
      case GamePlayerStatus.CONFIRMED:
        return Colors.blue.withOpacity(.5);
      case GamePlayerStatus.READY:
        return Colors.green.withOpacity(.5);
    }
  }
}
