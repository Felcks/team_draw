import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_randomizer/modules/randomizer/domain/models/team.dart';
import 'package:team_randomizer/modules/randomizer/domain/usecases/team_randomizer_use_case.dart';
import 'package:team_randomizer/modules/randomizer/presentation/player_widget.dart';

import '../../game/domain/models/player.dart';
import '../domain/usecases/team_randomizer_using_stars_use_case.dart';

class RandomizerPage extends StatefulWidget {
  const RandomizerPage({Key? key}) : super(key: key);

  @override
  State<RandomizerPage> createState() => _RandomizerPageState();
}

class _RandomizerPageState extends State<RandomizerPage> {
  List<Player> players = List.empty(growable: true);
  List<Team> teams = List.empty(growable: true);
  TextEditingController newPlayerTextFieldController = TextEditingController();
  TextEditingController amountOfTeamsTextFieldController = TextEditingController();
  TextEditingController playersPerTeamTextFieldController = TextEditingController();

  TeamRandomizerUseCase teamRandomizerUseCase = TeamRandomizerUsingStarsImpl();
  TeamRandomizerUseCase teamRandomizerTrivialUseCase = TeamRandomizerTrivialImpl();

  @override
  void initState() {
    super.initState();
    playersPerTeamTextFieldController.text = "5";
    amountOfTeamsTextFieldController.text = "2";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: getList()),
      floatingActionButton: getFloatActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  FloatingActionButton getFloatActionButton() {
    if (teams.isNotEmpty) {
      return FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            teams.clear();
          });
        },
        label: Text("Desfazer times"),
      );
    } else {
      return FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            teams = teamRandomizerUseCase.invoke(
              players,
              TeamRandomizerUseCaseParameters(
                teamsAmount: int.parse(amountOfTeamsTextFieldController.text),
                playersInEachTeam: int.parse(playersPerTeamTextFieldController.text),
              ),
            );
          });
        },
        label: Text("Sortear times"),
      );
    }
  }

  Widget getList() {
    if (teams.isNotEmpty) {
      return teamsWidget();
    }

    return playersWidget();
  }

  Widget teamsWidget() {
    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        Team team = teams[index];
        return ListView.builder(
          shrinkWrap: true,
          itemCount: team.players.length + 1,
          itemBuilder: (context, index) {
            if (index > 0) {
              Player player = team.players[index - 1];
              return PlayerWidget(
                player: player,
                position: index,
                changeStarCallback: (callbackPlayer) {
                  team.players[index - 1] = callbackPlayer;
                },
              );
            } else {
              return Text(
                team.teamName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              );
            }
          },
        );
      },
    );
  }

  Widget playersWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
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
              }),
        ),
        Flexible(
            flex: 2,
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TextField(
                        controller: newPlayerTextFieldController,
                      )),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              Player player = Player(name: newPlayerTextFieldController.text, overall: 1);
                              players.add(player);
                              newPlayerTextFieldController.clear();
                            });
                          },
                          child: Text("Adicionar"))
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text("Qtd times: "),
                        flex: 5,
                      ),
                      Flexible(
                        child: TextField(
                          controller: amountOfTeamsTextFieldController,
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text("Jogadores por time: "),
                        flex: 5,
                      ),
                      Flexible(
                        child: TextField(
                          controller: playersPerTeamTextFieldController,
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 100)
                ],
              ),
            )),
      ],
    );
  }
}
