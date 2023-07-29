import 'package:team_randomizer/modules/player/domain/player.dart';
import 'package:team_randomizer/modules/team/domain/models/team.dart';

class TeamPlayer {

  final Team team;
  final Player player;
  final String matchId;

  TeamPlayer({required this.team, required this.player, required this.matchId});
}