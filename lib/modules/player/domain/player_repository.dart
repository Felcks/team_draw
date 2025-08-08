import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_randomizer/modules/player/domain/player.dart';
import 'package:team_randomizer/modules/player/data/player_dto.dart';

abstract class PlayerRepository {
  void createPlayer(Player player);

  void editPlayer(Player player);

  void Function() listenPlayers(String groupId, Function(List<Player> list) onValue);

  Future<List<Player>> getPlayers(String groupId);
}

class PlayerRepositoryImpl extends PlayerRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void createPlayer(Player player) {
    PlayerDTO dto = PlayerDTO(
      id: player.id,
      groupId: player.groupId,
      name: player.name,
      overall: player.overall,
    );

    _db
        .collection("players")
        .add(dto.toJson())
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  @override
  void editPlayer(Player player) {
    PlayerDTO dto = PlayerDTO(
      id: player.id,
      groupId: player.groupId,
      name: player.name,
      overall: player.overall,
    );

    _db.collection("players").where("id", isEqualTo: dto.id).get().then(
          (value) {
        _db.collection("players").doc(value.docs.first.id).update(dto.toJson());
      },
    );
  }

  @override
  void Function() listenPlayers(String groupId, Function(List<Player> list) onValue) {
    final subscription = _db.collection("players").where("groupId", isEqualTo: groupId).snapshots().listen((event) {
      final result = event.docs.map(
            (doc) {
          PlayerDTO dto = PlayerDTO.fromJson(doc.data());
          return Player(
            id: dto.id,
            groupId: dto.groupId,
            name: dto.name,
            overall: dto.overall,
          );
        },
      );

      onValue.call(result.toList());
    });

    return () => subscription.cancel();
  }

  @override
  Future<List<Player>> getPlayers(String groupId) async {
    final value = await _db.collection("players").where("groupId", isEqualTo: groupId).get();
    return value.docs.map((doc) {
      PlayerDTO dto = PlayerDTO.fromJson(doc.data());
      return Player(
        id: dto.id,
        groupId: dto.groupId,
        name: dto.name,
        overall: dto.overall,
      );
    }).toList();
  }

}
