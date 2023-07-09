import 'dart:math';

import 'package:team_randomizer/modules/game/domain/models/player.dart';
import 'package:team_randomizer/modules/randomizer/domain/models/team.dart';
import 'package:team_randomizer/modules/randomizer/domain/usecases/team_randomizer_use_case.dart';

class TeamRandomizerUsingStarsImpl extends TeamRandomizerUseCase {
  @override
  List<Team> invoke(List<Player> players,
      TeamRandomizerUseCaseParameters teamRandomizerConfiguration) {
    CriteriaPlayers bestCriteria = CriteriaPlayers(
        players: players.toList(),
        criteriaResult:
            calculateCriteria(players, teamRandomizerConfiguration));

    for (int i = 0; i < 100; i++) {
      int pos1 = Random().nextInt(players.length);
      int pos2 = Random().nextInt(players.length);

      Player aux = players[pos1];
      players[pos1] = players[pos2];
      players[pos2] = aux;

      double currentCriteria =
          calculateCriteria(players, teamRandomizerConfiguration);
      if (currentCriteria < bestCriteria.criteriaResult) {
        bestCriteria =
            CriteriaPlayers(players: players.map((e) => e).toList(), criteriaResult: currentCriteria);
      }
    }

    players = bestCriteria.players;
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

    if (teamRandomizerConfiguration.leftoverPlayersAction ==
        LeftoverPlayersAction.BENCH) {
      int currentBenchTeam = 0;
      for (int i = teamRandomizerConfiguration.teamsAmount *
              teamRandomizerConfiguration.playersInEachTeam;
          i < players.length;
          i++) {
        teams[currentBenchTeam].players.add(players[i]);
        currentBenchTeam += 1;
        currentBenchTeam = currentBenchTeam % teams.length;
      }
    } else if (teamRandomizerConfiguration.leftoverPlayersAction ==
        LeftoverPlayersAction.EXTRA_TEAM) {
      Team extraTeam = Team(
          teamName: "Time ${teamRandomizerConfiguration.teamsAmount}",
          players: players.sublist(teamRandomizerConfiguration.teamsAmount *
              teamRandomizerConfiguration.playersInEachTeam));
      if (extraTeam.players.isNotEmpty) {
        teams.add(extraTeam);
      }
    }

    return teams;
  }
}

class CriteriaPlayers {
  final List<Player> players;
  final double criteriaResult;

  CriteriaPlayers({required this.players, required this.criteriaResult});
}

double calculateCriteria(List<Player> players,
    TeamRandomizerUseCaseParameters teamRandomizerConfiguration) {
  double totalMedia = 0;
  List<double> teamsMedia = List.empty(growable: true);
  for (int i = 0; i < teamRandomizerConfiguration.teamsAmount; i++) {

    int startIndex = i * teamRandomizerConfiguration.playersInEachTeam;
    teamsMedia.add(
        (players
            .getRange(startIndex, startIndex + teamRandomizerConfiguration.playersInEachTeam)
            .map((e) => e.overall)
            .reduce((value, element) => value + element)) /
        teamRandomizerConfiguration.playersInEachTeam);
  }

  totalMedia = teamsMedia.reduce((value, element) => value + element) /
      teamRandomizerConfiguration.teamsAmount;

  double distanceBetweenEachTeamAndTheMedia = 0;
  for (int i = 0; i < teamsMedia.length; i++) {
    distanceBetweenEachTeamAndTheMedia += (teamsMedia[i] - totalMedia).abs();
  }
  return distanceBetweenEachTeamAndTheMedia;
}
