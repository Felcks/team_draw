import 'package:team_randomizer/modules/player/domain/player.dart';

class Team {
  final String teamName;
  final List<Player> players;

  Team({required this.teamName, required this.players});

  double teamOverall() {
    return (players.map((e) => e.overall).reduce((value, element) => value + element) / players.length);
  }
}