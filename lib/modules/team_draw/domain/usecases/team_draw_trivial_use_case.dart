import 'dart:math';

import '../../../game/domain/models/player.dart';
import '../../../randomizer/domain/models/team.dart';
import '../models/team_draw.dart';
import 'team_draw_use_case.dart';

class TeamDrawTrivialUseCase extends TeamDrawUseCase {

  @override
  TeamDraw invoke(TeamDrawUseCaseParams params) {
    List<Player> players = params.players;
    int teamsGenerated = (players.length / params.playersPerTeam).toInt();

    for (int i = 0; i < 100; i++) {
      int pos1 = Random().nextInt(players.length);
      int pos2 = Random().nextInt(players.length);

      Player aux = players[pos1];
      players[pos1] = players[pos2];
      players[pos2] = aux;
    }

    List<Team> teams = generateTeams(players, teamsGenerated, params.playersPerTeam);
    return TeamDraw(players: params.players, createdAt: DateTime.now(), teams: teams);
  }
}