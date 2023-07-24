import 'package:team_randomizer/modules/team/domain/models/team.dart';

import '../../../player/domain/player.dart';


class SortedTeam {

  final Team team;
  final List<Player> players;

  SortedTeam({required this.team, required this.players});

  double getOverall() {
    return (players.map((e) => e.overall).reduce((value, element) => value + element) / players.length);
  }
}