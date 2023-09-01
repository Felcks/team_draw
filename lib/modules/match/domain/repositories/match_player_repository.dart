import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_randomizer/modules/match/data/models/match_player_dto.dart';
import 'package:team_randomizer/modules/match/domain/models/match_player.dart';
import 'package:team_randomizer/modules/match/domain/models/match_player_status.dart';
import 'package:team_randomizer/modules/player/domain/player_repository.dart';

import '../../../player/domain/player.dart';

abstract class MatchPlayerRepository {
  void createMatchPlayer(MatchPlayer input);

  void editMatchPlayer(MatchPlayer input);

  void Function() listenMatchPlayers(String groupId, String matchId, onValue(List<MatchPlayer> list));
}

class MatchPlayerRepositoryImpl extends MatchPlayerRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  PlayerRepository playerRepository = PlayerRepositoryImpl();

  @override
  void createMatchPlayer(MatchPlayer input) {
    MatchPlayerDTO dto = MatchPlayerDTO(playerId: input.player.id, matchId: input.matchId, status: input.status.name);

    _db.collection("match_player").add(dto.toJson()).then((value) => print("DocumentId ${value.id}"));
  }

  @override
  void editMatchPlayer(MatchPlayer input) {
    MatchPlayerDTO dto = MatchPlayerDTO(playerId: input.player.id, matchId: input.matchId, status: input.status.name);
    _db.collection("match_player").where("playerId", isEqualTo: dto.playerId).where("matchId", isEqualTo: dto.matchId).get().then(
          (value) {
        _db.collection("match_player").doc(value.docs.first.id).update(dto.toJson());
      },
    );
  }

  @override
  void Function() listenMatchPlayers(String groupId, String matchId, Function(List<MatchPlayer> list) onValue) {
    final subscription = _db.collection("match_player").where("matchId", isEqualTo: matchId).snapshots().listen((event) async {
      final players = await playerRepository.getPlayers(groupId);
      final result = event.docs.map(
        (doc) {
          MatchPlayerDTO dto = MatchPlayerDTO.fromJson(
            doc.data(),
          );

          Player player = players.firstWhere((element) => element.id == dto.playerId);

          return MatchPlayer(
            player: player,
            matchId: dto.matchId,
            status: MatchPlayerStatus.values.firstWhere((element) => element.name == dto.status),
          );
        },
      );

      onValue.call(result.toList());
    });

    return () => subscription.cancel();
  }
}
