import 'package:team_randomizer/modules/game/domain/models/player.dart';
import 'package:team_randomizer/modules/match/domain/models/match_player_status.dart';

class MatchPlayer {

  final String id;
  final Player player;
  final MatchPlayerStatus status;

  MatchPlayer({required this.id, required this.player, required this.status});
}