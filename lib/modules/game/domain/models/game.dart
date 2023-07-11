import 'package:team_randomizer/modules/game/domain/models/player.dart';

import 'game_player.dart';
import 'game_player_status.dart';

class Game {

  final DateTime date;
  final List<GamePlayer> players;

  Game({required this.date, required this.players});

  List<Player> getReadyPlayers() {
    return players.where((element) => element.status == GamePlayerStatus.READY).map((e) => e.player).toList(growable: true);
  }
}