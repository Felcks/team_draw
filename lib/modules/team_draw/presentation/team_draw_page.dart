import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/core/data/database_utils.dart';
import 'package:team_randomizer/modules/game/domain/models/game_player_status.dart';
import 'package:team_randomizer/modules/team_draw/domain/models/team_draw.dart';
import 'package:team_randomizer/modules/team_draw/domain/repositories/team_draw_repository.dart';
import 'package:team_randomizer/modules/team_draw/domain/usecases/team_draw_overall_use_case.dart';
import 'package:team_randomizer/modules/team_draw/domain/usecases/team_draw_use_case.dart';

import '../../game/domain/models/game.dart';
import '../../game/domain/models/game_player.dart';
import '../../game/domain/models/player.dart';
import '../../game/presentation/group_home/new_player_widget.dart';
import '../../randomizer/domain/models/team.dart';

class TeamDrawPage extends StatefulWidget {
  final Game game;

  const TeamDrawPage({Key? key, required this.game}) : super(key: key);

  @override
  State<TeamDrawPage> createState() => _TeamDrawPageState();
}

class _TeamDrawPageState extends State<TeamDrawPage> {
  int _playersPerTeam = 5;
  TeamDrawUseCase _teamRandomizerUseCase = TeamDrawOverallUseCase();
  TeamDrawRepository teamDrawRepository = TeamDrawRepository();

  TeamDraw? _teamDraw = null;

  List<GamePlayer> getPlayersReady() => _players.where((element) => element.status == GamePlayerStatus.READY).toList();

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

  void listenToGamePlayersUpdate() {
    database.ref("game_player").onValue.listen((allGamePlayers) async {
      DataSnapshot gamePlayerSnapshot = allGamePlayers.snapshot;
      List<DataSnapshot> gamePlayersOnThisGame = gamePlayerSnapshot.children.where((element) {
        Map<Object?, Object?> gamePlayerMap = element.value as Map<Object?, Object?>;
        return gamePlayerMap["gameId"] == widget.game.id;
      }).toList(growable: true);

      List<GamePlayer> playersWithStatusUpdated = _players.map((player) {
        DataSnapshot gamePlayerSnapshot = gamePlayersOnThisGame
            .firstWhere((element) => (element.value as Map<Object?, Object?>)["playerId"] == player.player.id);

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
    listenToGamePlayersUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: playersListWidget(
        widget.game.players.where((element) => element.status == GamePlayerStatus.READY).toList(),
      ),*/
      body: teamDrawHome(),
      floatingActionButton: getFloatActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget teamDrawHome() {
    if (_teamDraw == null) {
      return configuration();
    }

    return teamDraw(_teamDraw!);
  }

  Widget teamDraw(TeamDraw teamDraw) {
    List<Team> teams = teamDraw.teams;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              teams.length,
              (index) {
                Team team = teams[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            team.teamName,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                              "Overall - ${(team.players.map((e) => e.overall).reduce((value, element) => value + element) / team.players.length).toInt()}")
                        ],
                      ),
                      Column(
                        children: List.generate(
                          team.players.length,
                          (index) {
                            Player player = team.players[index];
                            return NewPlayerWidget(
                              player: player,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget configuration() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Configurações",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jogadores Prontos:",
                  style: _getConfigTextStyle(),
                ),
                Text(
                  "${_players.where((element) => element.status == GamePlayerStatus.READY).length}",
                  style: _getConfigTextStyle(),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jogadores por time:",
                  style: _getConfigTextStyle(),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if(_playersPerTeam > 0)
                                _playersPerTeam -= 1;
                            });
                          },
                          icon: Icon(Icons.remove_circle)),
                      Text(
                        _playersPerTeam.toString(),
                        style: _getConfigTextStyle(),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _playersPerTeam += 1;
                            });
                          },
                          icon: Icon(Icons.add_circle)),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantidade de times:",
                  style: _getConfigTextStyle(),
                ),
                Text(
                  "${teamsAmount()}",
                  style: _getConfigTextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int teamsAmount() {
    if (getPlayersReady().length == 0 || _playersPerTeam <= 0)
      return 0;
    else
      return (getPlayersReady().length / _playersPerTeam).toInt();
  }

  TextStyle _getConfigTextStyle() {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade600);
  }

  FloatingActionButton getFloatActionButton() {
    //if (teams.isNotEmpty) {
    if (_teamDraw != null) {
      return FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _teamDraw = null;
            teamDrawRepository.setTeamDraw(_teamDraw);
          });
        },
        label: Text("Desfazer times"),
      );
    } else {
      return FloatingActionButton.extended(
        onPressed: () {
          setState(
            () {
              _teamDraw = _teamRandomizerUseCase
                  .invoke(TeamDrawUseCaseParams(players: _players.map((e) => e.player).toList(), playersPerTeam: _playersPerTeam));
              teamDrawRepository.setTeamDraw(_teamDraw);
            },
          );
        },
        label: Text("Gerar times"),
      );
    }
  }

  Widget playersListWidget(List<GamePlayer> players) {
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
                    "Jogadores Prontos",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: players.length,
                itemBuilder: (context, index) {
                  GamePlayer gamePlayer = players[index];
                  return SizedBox(
                    height: 85,
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(height: 85, child: NewPlayerWidget(player: gamePlayer.player))),
                        Positioned(
                          left: 20,
                          top: 50,
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
}
