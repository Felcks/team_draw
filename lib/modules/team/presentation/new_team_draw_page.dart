import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/match/domain/models/match_player_status.dart';
import 'package:team_randomizer/modules/team/domain/models/generated_team.dart';
import 'package:team_randomizer/modules/team/domain/models/team.dart';
import 'package:team_randomizer/modules/team/domain/models/team_player.dart';
import 'package:team_randomizer/modules/team/domain/repositories/team_player_repository.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';
import 'package:team_randomizer/modules/team/domain/repositories/team_repository.dart';
import 'package:team_randomizer/modules/team_draw/domain/usecases/team_draw_overall_use_case.dart';
import 'package:team_randomizer/modules/team_draw/domain/usecases/team_draw_use_case.dart';
import 'package:uuid/uuid.dart';

import '../../match/domain/models/match_player.dart';
import '../../match/domain/repositories/match_player_repository.dart';
import '../../team_draw/domain/models/team_draw.dart';

class NewTeamDrawPage extends StatefulWidget {
  final Match match;

  const NewTeamDrawPage({Key? key, required this.match}) : super(key: key);

  @override
  State<NewTeamDrawPage> createState() => _NewTeamDrawPageState();
}

class _NewTeamDrawPageState extends State<NewTeamDrawPage> {
  TeamRepository _teamRepository = TeamRepositoryImpl();
  TeamPlayerRepository teamPlayerRepository = TeamPlayerRepositoryImpl();
  MatchPlayerRepository _matchPlayerRepository = MatchPlayerRepositoryImpl();

  List<MatchPlayer> _matchPlayers = List.empty(growable: true);
  List<GeneratedTeam> _generatedTeams = List.empty(growable: true);

  Function() _matchPlayerUpdateUnregister = () {};
  Function() _teamPlayersUpdateUnregister = () {};

  int _playersPerTeam = 5;

  TeamDrawUseCase _teamDrawUseCase = TeamDrawOverallUseCase();


  //TODO: Create Widgets to show the teams (copy from old team_draw)
  //TODO: New usecase to randomize teams with new classes
  //TODO: Move Player to right package
  //TODO: Erase old code (team_draw, game, group, old views, old use cases)
  //TODO: Make stopwatch decreasing time
  //TODO: Allow change team configuration (side by side with matches, but 1/4 of size, search icon)

  @override
  void initState() {
    super.initState();

    _matchPlayerUpdateUnregister = _matchPlayerRepository.listenMatches((list) {
      setState(() {
        _matchPlayers = list;
      });
    });

    _teamPlayersUpdateUnregister = teamPlayerRepository.listenTeamPlayers((list) {
      //Move this logic to a use case
      List<GeneratedTeam> generatedTeams = List.empty(growable: true);

      list.forEach((element) {
        List<String> generatedTeamsIds = generatedTeams.map((e) => e.team.id).toList();
        if (generatedTeamsIds.contains(element) == false) {
          generatedTeams.add(GeneratedTeam(team: element.team, player: [element.player]));
        } else {
          generatedTeams
              .firstWhere((generatedTeam) => generatedTeam.team.id == element.team.id)
              .player
              .add(element.player);
        }
      });

      setState(() {
        _generatedTeams = generatedTeams;
      });
    });
  }

  @override
  void dispose() {
    _teamPlayersUpdateUnregister.call();
    _matchPlayerUpdateUnregister.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: drawHome(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            TeamDraw teamDraw = _teamDrawUseCase.invoke(TeamDrawUseCaseParams(
                players: getPlayersReady().map((e) => e.player).toList(), playersPerTeam: _playersPerTeam));
            teamDraw.teams.forEach((team) {
              Team newTeam = Team(id: Uuid().v4(), name: team.teamName);
              _teamRepository.createTeam(newTeam);

              team.players.forEach((element) {
                teamPlayerRepository.createTeamPlayer(TeamPlayer(team: newTeam, player: element));
              });
            });
          },
          label: Text("Gerar times")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget drawHome() {
    if (_generatedTeams.isEmpty) {
      return _configurationWidget();
    }

    return Column(children: List.generate(_generatedTeams.length, (index) => Text(_generatedTeams[index].team.name)));
  }

  Widget _configurationWidget() {
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
                  "${getPlayersReady().length}",
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
                              if (_playersPerTeam > 0) _playersPerTeam -= 1;
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

  TextStyle _getConfigTextStyle() {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade600);
  }

  List<MatchPlayer> getPlayersReady() {
    return _matchPlayers.where((element) => element.status == MatchPlayerStatus.READY).toList();
  }

  int teamsAmount() {
    if (getPlayersReady().length == 0 || _playersPerTeam <= 0)
      return 0;
    else
      return (getPlayersReady().length / _playersPerTeam).toInt();
  }
}
