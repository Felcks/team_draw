import '../models/player.dart';

class PlayerRepository {

  List<Player> getPlayers() {
    return [
      Player(name: "Matheus", overall: 100),
      Player(name: "Arthur", overall: 88),
      Player(name: "José", overall: 33),
      Player(name: "Felipe", overall: 22),
      Player(name: "Guilherme", overall: 47),
      Player(name: "Pedro Gomes", overall: 99),
      Player(name: "Ezequiel", overall: 76),
      Player(name: "Gustavo", overall: 55),
      Player(name: "Wanderson", overall: 65),
      Player(name: "Daniel", overall: 82),
    ];
  }
}