import 'dart:math';

import 'package:team_randomizer/modules/game/domain/models/game_player.dart';
import 'package:team_randomizer/modules/team_draw/domain/models/team_draw.dart';

import '../../../game/domain/models/game.dart';
import '../../../game/domain/models/player.dart';
import '../../../randomizer/domain/models/team.dart';

class TeamDrawUseCaseParams {
  List<Player> players;
  int playersPerTeam;

  TeamDrawUseCaseParams({required this.players, required this.playersPerTeam});
}

abstract class TeamDrawUseCase {
  TeamDraw invoke(TeamDrawUseCaseParams params);

  List<Team> generateTeams(List<Player> players, int teamsGenerated, int playersPerTeam) {
    return List.generate(
      teamsGenerated,
          (index) => Team(
        teamName: "Time $index",
        players: players.sublist(index * playersPerTeam, index * playersPerTeam + playersPerTeam),
      ),
    );
  }
}