import 'package:team_randomizer/modules/player/domain/player.dart';
import 'package:team_randomizer/modules/match/domain/models/match_player_status.dart';

class MatchPlayer {

  final String matchId;
  final Player player;
  final MatchPlayerStatus status;

  MatchPlayer({required this.matchId, required this.player, required this.status});
}