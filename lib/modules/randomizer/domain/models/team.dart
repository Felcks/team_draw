import 'package:team_randomizer/modules/game/domain/models/player.dart';

class Team {
  final String teamName;
  final List<Player> players;

  Team({required this.teamName, required this.players});
}