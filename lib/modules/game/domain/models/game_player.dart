import 'package:team_randomizer/modules/game/domain/models/game_player_status.dart';
import 'package:team_randomizer/modules/game/domain/models/player.dart';

class GamePlayer {

  final Player player;
  final GamePlayerStatus status;

  GamePlayer({required this.player, required this.status});
}