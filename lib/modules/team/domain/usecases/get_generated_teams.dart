import '../models/generated_team.dart';
import '../repositories/team_player_repository.dart';

abstract class GetGeneratedTeamsUseCase {
  TeamPlayerRepository teamPlayerRepository = TeamPlayerRepositoryImpl();

  void Function() invoke(Function(List<GeneratedTeam> list) onValue);
}

class GetGeneratedTeamsUseCaseImpl extends GetGeneratedTeamsUseCase {
  @override
  void Function() invoke(Function(List<GeneratedTeam> list) onValue) {
    Function() teamPlayersUpdateUnregister = teamPlayerRepository.listenTeamPlayers((list) {
      List<GeneratedTeam> generatedTeams = List.empty(growable: true);

      list.forEach((element) {
        List<String> generatedTeamsIds = generatedTeams.map((e) => e.team.id).toList();
        if (generatedTeamsIds.contains(element) == false) {
          generatedTeams.add(GeneratedTeam(team: element.team, players: [element.player]));
        } else {
          generatedTeams
              .firstWhere((generatedTeam) => generatedTeam.team.id == element.team.id)
              .players
              .add(element.player);
        }

        onValue(generatedTeams);
      });
    });

    return teamPlayersUpdateUnregister;
  }
}
