import 'package:team_randomizer/modules/game/domain/models/game.dart';
import 'package:team_randomizer/modules/game/domain/models/game_player.dart';
import 'package:team_randomizer/modules/game/domain/models/game_player_status.dart';
import 'package:team_randomizer/modules/game/domain/repositories/player_repository.dart';

class GameRepository {
  PlayerRepository playerRepository = PlayerRepository();

  List<Game> getGames() {
    return [
      Game(
        date: DateTime.now(),
        players: playerRepository
            .getPlayers()
            .map((e) => GamePlayer(player: e, status: GamePlayerStatus.READY))
            .toList(),
      ),
    ];
  }
}
