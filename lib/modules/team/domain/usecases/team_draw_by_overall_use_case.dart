import 'dart:math';

import 'package:team_randomizer/modules/player/domain/player.dart';
import 'package:team_randomizer/modules/team/domain/models/generated_team.dart';
import 'package:team_randomizer/modules/team/domain/models/team.dart';
import 'package:team_randomizer/modules/team/domain/usecases/team_draw_use_case.dart';
import 'package:uuid/uuid.dart';

class TeamDrawByOverallUseCase extends TeamDrawUseCase {
  @override
  List<SortedTeam> invoke(List<Player> players, int playersPerTeam) {
    int amountOfTeamsToGenerate = (players.length / playersPerTeam).toInt();
    List<SortedTeam> bestSortedTeams = generateTeams(players, amountOfTeamsToGenerate, playersPerTeam);
    double lowerStandardDerivation = calculateStandardDerivation(bestSortedTeams);

    for (int i = 0; i < 1000; i++) {
      int pos1 = Random().nextInt(players.length);
      int pos2 = Random().nextInt(players.length);

      Player aux = players[pos1];
      players[pos1] = players[pos2];
      players[pos2] = aux;

      List<SortedTeam> sortedTeams = generateTeams(players, amountOfTeamsToGenerate, playersPerTeam);
      double currentStandardDerivation = calculateStandardDerivation(sortedTeams);
      if (currentStandardDerivation < lowerStandardDerivation) {
        lowerStandardDerivation = currentStandardDerivation;
        bestSortedTeams = sortedTeams;
      }
    }

    return bestSortedTeams;
  }

  List<SortedTeam> generateTeams(List<Player> players, int teamsGenerated, int playersPerTeam) {
    List<SortedTeam> result = List.generate(
      teamsGenerated,
      (index) => SortedTeam(
        team: Team(id: Uuid().v4(), name: "Time ${index + 1}"),
        players: players.sublist(index * playersPerTeam, index * playersPerTeam + playersPerTeam),
      ),
    );

    if(players.length > playersPerTeam * teamsGenerated) {
      SortedTeam benchTeam = SortedTeam(team: Team(id: Uuid().v4(), name: "Time ${teamsGenerated + 1}"), players: players.sublist(playersPerTeam * teamsGenerated));
      result.add(benchTeam);
    }

    return result;
  }

  double calculateStandardDerivation(List<SortedTeam> teams) {
    List<double> teamsOverall = teams.map((e) => e.getOverall()).toList(growable: false);
    double mean = (teamsOverall.reduce((value, element) => value + element) / teams.length);
    double variance = (teamsOverall.reduce((value, element) => value + pow(element - mean, 2)) / teams.length);
    double derivation = sqrt(variance);
    return derivation;
  }
}