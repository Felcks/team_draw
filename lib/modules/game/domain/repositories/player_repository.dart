import '../models/player.dart';

class PlayerRepository {

  List<Player> getPlayers() {
    return [
      Player(id: "", groupId: "", name: "Matheus", overall: 100),
      Player(id: "", groupId: "", name: "Arthur", overall: 88),
      Player(id: "", groupId: "", name: "José", overall: 33),
      Player(id: "", groupId: "", name: "Felipe", overall: 22),
      Player(id: "", groupId: "", name: "Guilherme", overall: 47),
      Player(id: "", groupId: "", name: "Pedro Gomes", overall: 99),
      Player(id: "", groupId: "", name: "Ezequiel", overall: 76),
      Player(id: "", groupId: "", name: "Gustavo", overall: 55),
      Player(id: "", groupId: "", name: "Wanderson", overall: 65),
      Player(id: "", groupId: "", name: "Daniel", overall: 82),
    ];
  }
}