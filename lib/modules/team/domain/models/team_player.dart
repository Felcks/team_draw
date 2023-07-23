import 'package:team_randomizer/modules/game/domain/models/player.dart';
import 'package:team_randomizer/modules/team/domain/models/team.dart';

class TeamPlayer {

  final Team team;
  final Player player;

  TeamPlayer({required this.team, required this.player});
}