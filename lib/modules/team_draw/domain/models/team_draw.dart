import '../../../game/domain/models/game.dart';
import '../../../game/domain/models/player.dart';
import '../../../randomizer/domain/models/team.dart';

class TeamDraw {
  final List<Player> players;
  final DateTime createdAt;
  final List<Team> teams;

  TeamDraw({required this.players, required this.createdAt, required this.teams});
}