import '../models/generated_team.dart';
import '../repositories/team_player_repository.dart';

abstract class GetGeneratedTeamsUseCase {
  TeamPlayerRepository teamPlayerRepository = TeamPlayerRepositoryImpl();

  void Function() invoke(String groupId, String matchId, Function(List<SortedTeam> list) onValue);
}

class GetGeneratedTeamsUseCaseImpl extends GetGeneratedTeamsUseCase {
  @override
  void Function() invoke(String groupId, String matchId, Function(List<SortedTeam> list) onValue) {
    Function() teamPlayersUpdateUnregister = teamPlayerRepository.listenTeamPlayers(groupId, matchId, (list) {
      List<SortedTeam> generatedTeams = List.empty(growable: true);

      list.forEach((element) {
        List<String> generatedTeamsIds = generatedTeams.map((e) => e.team.id).toList();
        if (generatedTeamsIds.contains(element.team.id) == false) {
          generatedTeams.add(SortedTeam(team: element.team, players: [element.player]));
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
