import 'dart:math';

import 'package:team_randomizer/modules/game/domain/models/game_player_status.dart';
import 'package:team_randomizer/modules/team_draw/domain/models/team_draw.dart';

import '../../../game/domain/models/game.dart';
import '../../../game/domain/models/player.dart';
import '../../../randomizer/domain/models/team.dart';

class NewTeamRandomizerUseCaseParams {
  Game game;
  int playersPerTeam;

  NewTeamRandomizerUseCaseParams({required this.game, required this.playersPerTeam});
}

abstract class NewTeamRandomizerUseCase {
  TeamDraw invoke(NewTeamRandomizerUseCaseParams params);
}

class NewTeamRandomizerTrivialUseCase extends NewTeamRandomizerUseCase {

  @override
  TeamDraw invoke(NewTeamRandomizerUseCaseParams params) {

    List<Player> players = params.game.players.where((element) => element.status == GamePlayerStatus.READY).map((e) => e.player).toList(growable: true);
    int teamsGenerated = (players.length / params.playersPerTeam).toInt();

    for (int i = 0; i < 100; i++) {
      int pos1 = Random().nextInt(players.length);
      int pos2 = Random().nextInt(players.length);

      Player aux = players[pos1];
      players[pos1] = players[pos2];
      players[pos2] = aux;
    }

    List<Team> teams = List.generate(
      teamsGenerated,
          (index) => Team(
        teamName: "Time $index",
        players: players.sublist(
            index * params.playersPerTeam,
            index * params.playersPerTeam + params.playersPerTeam),
      ),
    );

    return TeamDraw(game: params.game, createdAt: DateTime.now(), teams: teams);
  }

}