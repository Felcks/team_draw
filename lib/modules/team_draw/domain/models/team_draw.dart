import '../../../game/domain/models/game.dart';
import '../../../randomizer/domain/models/team.dart';

class TeamDraw {
  final Game game;
  final DateTime createdAt;
  final List<Team> teams;

  TeamDraw({required this.game, required this.createdAt, required this.teams});
}