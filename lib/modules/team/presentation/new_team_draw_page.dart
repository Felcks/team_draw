import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/match/domain/models/match_player_status.dart';
import 'package:team_randomizer/modules/team/domain/models/generated_team.dart';
import 'package:team_randomizer/modules/team/domain/models/team_player.dart';
import 'package:team_randomizer/modules/team/domain/repositories/team_player_repository.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';
import 'package:team_randomizer/modules/team/domain/repositories/team_repository.dart';
import 'package:team_randomizer/modules/team/domain/usecases/get_generated_teams.dart';
import 'package:team_randomizer/modules/team/domain/usecases/team_draw_by_overall_use_case.dart';
import 'package:team_randomizer/modules/team/domain/usecases/team_draw_use_case.dart';
import '../../player/domain/player.dart';
import '../../match/domain/models/match_player.dart';
import '../../match/domain/repositories/match_player_repository.dart';
import '../../player/presentation/new_player_widget.dart';

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
  List<SortedTeam> _sortedTeams = List.empty(growable: true);

  Function() _matchPlayerUpdateUnregister = () {};
  Function() _teamPlayersUpdateUnregister = () {};

  int _playersPerTeam = 1;

  //TODO: Create Widgets to show the teams (copy from old team_draw)
  //TODO: New usecase to randomize teams with new classes
  //TODO: Move Player to right package
  //TODO: Erase old code (team_draw, game, group, old views, old use cases)
  //TODO: Make stopwatch decreasing time
  //TODO: Allow change team configuration (side by side with matches, but 1/4 of size, search icon)

  GetGeneratedTeamsUseCase _generatedTeamsUseCase = GetGeneratedTeamsUseCaseImpl();
  TeamDrawUseCase _teamDrawUseCase = TeamDrawByOverallUseCase();

  @override
  void initState() {
    super.initState();
    listenToUpdates();
  }

  void listenToUpdates() {
    _matchPlayerUpdateUnregister = _matchPlayerRepository.listenMatchPlayers(widget.match.id, (list) {
      setState(() {
        _matchPlayers = list;
      });
    });

    _teamPlayersUpdateUnregister = _generatedTeamsUseCase.invoke(widget.match.id, (list) {
      setState(() {
        _sortedTeams = list;
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
      floatingActionButton: getFloatActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget drawHome() {
    if (_sortedTeams.isEmpty) {
      return Center(
        child: Text("Nenhum time sorteado"),
      );
    } else {
      return _showTeamsWidget();
    }
  }

  void executeTeamDraw() {
    _sortedTeams = _teamDrawUseCase.invoke(getPlayersReady().map((e) => e.player).toList(), _playersPerTeam);
    saveSortedTeams();
  }

  void saveSortedTeams() {
    _sortedTeams.forEach((sortedTeam) {
      _teamRepository.createTeam(sortedTeam.team);

      sortedTeam.players.forEach((player) {
        teamPlayerRepository.createTeamPlayer(TeamPlayer(team: sortedTeam.team, player: player, matchId: widget.match.id));
      });
    });
  }

  void cleanSortedTeams() {
    _teamPlayersUpdateUnregister.call();
    _matchPlayerUpdateUnregister.call();

    _sortedTeams.forEach((sortedTeam) {
      sortedTeam.players.forEach((element) {
        teamPlayerRepository.deleteTeamPlayer(TeamPlayer(team: sortedTeam.team, player: element, matchId: widget.match.id));
      });
      _teamRepository.deleteTeam(sortedTeam.team);
    });

    listenToUpdates();
  }

  Widget _showTeamsWidget() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              _sortedTeams.length,
              (index) {
                SortedTeam generatedTeam = _sortedTeams[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            generatedTeam.team.name,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Overall - ${(generatedTeam.players.map((e) => e.overall).reduce((value, element) => value + element) / generatedTeam.players.length).toInt()}",
                          )
                        ],
                      ),
                      Column(
                        children: List.generate(
                          generatedTeam.players.length,
                          (index) {
                            Player player = generatedTeam.players[index];
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

  Widget _configurationWidget(void Function(void Function()) setModalState) {
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
                            setModalState(() {
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
                            setModalState(() {
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
            SizedBox(height: 32,),
            Center(child: ElevatedButton(onPressed: () {
              cleanSortedTeams();
              executeTeamDraw();
            }, child: Text("Sortear")))
          ],
        ),
      ),
    );
  }

  TextStyle _getConfigTextStyle() {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade600);
  }

  FloatingActionButton getFloatActionButton() {
    if (_sortedTeams.isEmpty) {
      return FloatingActionButton.extended(
        onPressed: () {
          _showConfiguration();
          //executeTeamDraw();
        },
        label: Text("Gerar times"),
      );
    } else {
      return FloatingActionButton.extended(
        onPressed: () {
          _showConfiguration();
          //cleanSortedTeams();
          //executeTeamDraw();
        },
        label: Text("Refazer times"),
      );
    }
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

  void _showConfiguration() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * .42,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                shape: BoxShape.rectangle,
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 32,
                    child: Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Sorteio",
                    style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.all(
                          Radius.circular(8),
                        ),
                        shape: BoxShape.rectangle,
                        color: Colors.grey.withOpacity(0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: _configurationWidget(setModalState),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
