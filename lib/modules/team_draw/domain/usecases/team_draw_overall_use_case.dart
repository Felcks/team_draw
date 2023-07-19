import 'dart:math';

import '../../../game/domain/models/player.dart';
import '../../../randomizer/domain/models/team.dart';
import '../models/team_draw.dart';
import 'team_draw_use_case.dart';

class TeamDrawOverallUseCase extends TeamDrawUseCase {
  @override
  TeamDraw invoke(TeamDrawUseCaseParams params) {
    List<Player> players = params.players;
    int teamsToBeGenerated = (players.length / params.playersPerTeam).toInt();
    List<Team> teams = generateTeams(players, teamsToBeGenerated, params.playersPerTeam);
    double lowerStandardDerivation = calculateStandardDerivation(teams);
    List<Team> bestTeams = teams;

    for (int i = 0; i < 1000; i++) {
      int pos1 = Random().nextInt(players.length);
      int pos2 = Random().nextInt(players.length);

      Player aux = players[pos1];
      players[pos1] = players[pos2];
      players[pos2] = aux;

      teams = generateTeams(players, teamsToBeGenerated, params.playersPerTeam);
      double currentStandardDerivation = calculateStandardDerivation(teams);
      if (currentStandardDerivation < lowerStandardDerivation) {
        lowerStandardDerivation = currentStandardDerivation;
        bestTeams = teams;
      }
    }

    return TeamDraw(players: params.players, createdAt: DateTime.now(), teams: bestTeams);
  }

  double calculateStandardDerivation(List<Team> teams) {
    List<double> teamsOverall = teams.map((e) => e.teamOverall()).toList(growable: false);
    double mean = (teamsOverall.reduce((value, element) => value + element) / teams.length);
    double variance = (teamsOverall.reduce((value, element) => value + pow(element - mean, 2)) / teams.length);
    double derivation = sqrt(variance);
    return derivation;
  }
}
