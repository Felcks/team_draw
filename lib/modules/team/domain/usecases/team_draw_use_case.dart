import 'package:team_randomizer/modules/team/domain/models/generated_team.dart';

import '../../../player/domain/player.dart';

abstract class TeamDrawUseCase {
  List<SortedTeam> invoke(List<Player> players, int playersPerTeam);
}