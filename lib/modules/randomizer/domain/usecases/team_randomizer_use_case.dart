import 'dart:math';

import 'package:team_randomizer/modules/game/domain/models/player.dart';
import 'package:team_randomizer/modules/randomizer/domain/models/team.dart';

abstract class TeamRandomizerUseCase {
  List<Team> invoke(List<Player> players, TeamRandomizerUseCaseParameters teamRandomizerConfiguration);
}

class TeamRandomizerUseCaseParameters {
  final int teamsAmount;
  final int playersInEachTeam;
  final LeftoverPlayersAction leftoverPlayersAction;

  TeamRandomizerUseCaseParameters({required this.teamsAmount, required this.playersInEachTeam, this.leftoverPlayersAction = LeftoverPlayersAction.EXTRA_TEAM});
}

enum LeftoverPlayersAction {
  BENCH,
  EXTRA_TEAM,
}

class TeamRandomizerTrivialImpl extends TeamRandomizerUseCase {
  @override
  List<Team> invoke(List<Player> players, TeamRandomizerUseCaseParameters teamRandomizerConfiguration) {
    for (int i = 0; i < 100; i++) {
      int pos1 = Random().nextInt(players.length);
      int pos2 = Random().nextInt(players.length);

      Player aux = players[pos1];
      players[pos1] = players[pos2];
      players[pos2] = aux;
    }

    List<Team> teams = List.generate(
      teamRandomizerConfiguration.teamsAmount,
      (index) => Team(
        teamName: "Time $index",
        players: players.sublist(
            index * teamRandomizerConfiguration.playersInEachTeam,
            index * teamRandomizerConfiguration.playersInEachTeam +
                teamRandomizerConfiguration.playersInEachTeam),
      ),
    );

    if(teamRandomizerConfiguration.leftoverPlayersAction == LeftoverPlayersAction.BENCH) {
      int currentBenchTeam = 0;
      for (int i = teamRandomizerConfiguration.teamsAmount *
          teamRandomizerConfiguration.playersInEachTeam; i <
          players.length; i++) {
        teams[currentBenchTeam].players.add(players[i]);
        currentBenchTeam += 1;
        currentBenchTeam = currentBenchTeam % teams.length;
      }
    } else if(teamRandomizerConfiguration.leftoverPlayersAction == LeftoverPlayersAction.EXTRA_TEAM) {
      Team extraTeam = Team(teamName: "Time ${teamRandomizerConfiguration.teamsAmount}", players: players.sublist(teamRandomizerConfiguration.teamsAmount * teamRandomizerConfiguration.playersInEachTeam));
      if(extraTeam.players.isNotEmpty) {
        teams.add(extraTeam);
      }
    }

    return teams;
  }
}
