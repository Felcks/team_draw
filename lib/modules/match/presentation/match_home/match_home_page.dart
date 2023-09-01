import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';
import 'package:team_randomizer/modules/match/domain/models/match_player.dart';
import 'package:team_randomizer/modules/match/domain/models/match_player_status.dart';
import 'package:team_randomizer/modules/match/domain/repositories/match_player_repository.dart';
import 'package:team_randomizer/modules/player/domain/player_repository.dart';
import 'package:team_randomizer/modules/player/presentation/match_player_widget.dart';
import 'package:team_randomizer/modules/team/presentation/new_team_draw_page.dart';

import '../../../stopwatch/presentation/timer_page.dart';

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
  final MatchPlayerRepository _matchPlayerRepository = MatchPlayerRepositoryImpl();
  bool _listeningPlayersChange = false;

  Function() _matchPlayerUpdateUnregister = () {};
  Function() _playerUpdateUnregister = () {};

  @override
  void initState() {
    super.initState();

    _matchPlayerUpdateUnregister = _matchPlayerRepository.listenMatchPlayers(widget.match.groupId, widget.match.id, (list) {
      setState(() {
        _matchPlayers = list;
        if (!_listeningPlayersChange) {
          _listeningPlayersChange = true;
          listenToPlayersChange();
        }
      });
    });
  }

  @override
  void dispose() {
    _matchPlayerUpdateUnregister.call();
    _playerUpdateUnregister.call();
    super.dispose();
  }

  void listenToPlayersChange() {
    _playerUpdateUnregister = playerRepository.listenPlayers(widget.match.groupId, (list) {
      list.forEach((element) {
        //adding status to a player that wasn't there
        List<String> playersIdOnMatchPlayers = _matchPlayers.map((e) => e.player.id).toList();
        if (playersIdOnMatchPlayers.contains(element.id) == false) {
          _matchPlayerRepository.createMatchPlayer(
              MatchPlayer(matchId: widget.match.id, player: element, status: MatchPlayerStatus.NOT_CONFIRMED));
        }
      });
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Partida ${DateFormat("EEEE (dd/MM)").format(widget.match.date)}",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
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
              ? NewTeamDrawPage(match: widget.match) //TeamDrawPage(game: widget.match)
              : TimerPage(),
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
                            child: MatchPlayerWidget(
                              matchPlayer: gamePlayer,
                              onMatchPlayerStatusUpdate: (player) {
                                _matchPlayerRepository.editMatchPlayer(player);
                              },
                            ),
                          ),
                        ),
                        /*Positioned.fill(
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
                        ),*/
                        /*Positioned(
                          left: 120,
                          top: 40,
                          child: PopupMenuButton<MatchPlayerStatus>(
                            initialValue: selectedMatchPlayerStatus,
                            // Callback that sets the selected popup menu item.
                            onSelected: (MatchPlayerStatus item) {
                              setState(() {
                                selectedMatchPlayerStatus = item;
                                _matchPlayerRepository.editMatchPlayer(MatchPlayer(
                                    matchId: gamePlayer.matchId,
                                    player: gamePlayer.player,
                                    status: selectedMatchPlayerStatus));
                              });
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<MatchPlayerStatus>>[
                              const PopupMenuItem<MatchPlayerStatus>(
                                value: MatchPlayerStatus.NOT_CONFIRMED,
                                child: Text('Não Confirmado'),
                              ),
                              const PopupMenuItem<MatchPlayerStatus>(
                                value: MatchPlayerStatus.CANCELLED,
                                child: Text('Cancelado'),
                              ),
                              const PopupMenuItem<MatchPlayerStatus>(
                                value: MatchPlayerStatus.CONFIRMED,
                                child: Text('Confirmado'),
                              ),
                              const PopupMenuItem<MatchPlayerStatus>(
                                value: MatchPlayerStatus.READY,
                                child: Text('Pronto'),
                              ),
                            ],
                          ),
                        ),*/
                        /*Positioned(
                          left: 15,
                          top: 55,
                          child: Text(
                            "(${gamePlayer.status.value})",
                            style: TextStyle(fontSize: 12),
                          ),
                        )*/
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
