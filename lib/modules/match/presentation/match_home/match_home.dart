import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/core/data/database_utils.dart';
import 'package:team_randomizer/modules/game/domain/models/game_player.dart';
import 'package:team_randomizer/modules/game/domain/models/game_player_status.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';
import 'package:team_randomizer/modules/match/domain/models/match_player.dart';
import 'package:team_randomizer/modules/match/domain/models/match_player_status.dart';
import 'package:team_randomizer/modules/match/domain/repositories/match_repository.dart';
import 'package:team_randomizer/modules/player/domain/player_repository.dart';

import '../../../stopwatch/presentation/timer_page.dart';
import '../../../player/presentation/new_player_widget.dart';

class MatchHomePage extends StatefulWidget {
  final Match match;

  const MatchHomePage({Key? key, required this.match}) : super(key: key);

  @override
  State<MatchHomePage> createState() => _MatchHomePageState();
}

class _MatchHomePageState extends State<MatchHomePage> {
  int _selectedIndex = 0;

  List<MatchPlayer> _matchPlayers = List.empty(growable: true);
  PlayerRepository playerRepository = PlayerRepositoryImpl();

  @override
  void initState() {
    super.initState();

    playerRepository.listenPlayers((list) {
      setState(() {
        _matchPlayers = list.map((e) => MatchPlayer(id: "", player: e, status: MatchPlayerStatus.NOT_CONFIRMED)).toList();
      });
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
      body: (_selectedIndex == 0)
          ? playersListWidget()
          : (_selectedIndex == 1)
              ? TimerPage() //TeamDrawPage(game: widget.match)
              : TimerPage(),
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
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _matchPlayers.length,
                itemBuilder: (context, index) {
                  MatchPlayer gamePlayer = _matchPlayers[index];
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
                                /*selectedGamePlayerStatus = item;
                                DatabaseReference ref = getDatabase().ref();
                                ref.child("game_player/${gamePlayer.id}").update({"status": item.name});*/
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

  Color getPlayerStatusColor(MatchPlayer player) {
    switch (player.status) {
      case MatchPlayerStatus.CANCELLED:
        return Colors.red.withOpacity(.5);
      case MatchPlayerStatus.NOT_CONFIRMED:
        return Colors.amber.withOpacity(.5);
      case MatchPlayerStatus.CONFIRMED:
        return Colors.blue.withOpacity(.5);
      case MatchPlayerStatus.READY:
        return Colors.green.withOpacity(.5);
    }
  }
}
