import 'package:team_randomizer/modules/team/domain/models/generated_team.dart';

import '../../../game/domain/models/player.dart';

abstract class TeamDrawUseCase {
  List<SortedTeam> invoke(List<Player> players, int playersPerTeam);
}