import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_randomizer/modules/match/data/models/match_dto.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';

abstract class MatchRepository {
  void createMatch(Match input);

  void editMatch(Match input);

  void Function() listenMatches(
    String groupId,
    Function(List<Match> list) onValue,
  );

  Future<List<Match>> getMatches(String groupId);
}

class MatchRepositoryImpl extends MatchRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void createMatch(Match input) {
    MatchDTO dto = MatchDTO(
      id: input.id,
      groupId: input.groupId,
      dateInMillis: input.date.millisecondsSinceEpoch,
    );

    _db.collection("matches").add(dto.toJson()).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  @override
  void editMatch(Match input) {
    MatchDTO dto = MatchDTO(
      id: input.id,
      groupId: input.groupId,
      dateInMillis: input.date.millisecondsSinceEpoch,
    );

    _db.collection("matches").add(dto.toJson()).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  @override
  void Function() listenMatches(
      String groupId, Function(List<Match> list) onValue) {
    final subscription = _db
        .collection("matches")
        .where("groupId", isEqualTo: groupId)
        .snapshots()
        .listen((event) {
      final result = event.docs.map(
        (doc) {
          MatchDTO dto = MatchDTO.fromJson(doc.data());
          return Match(
              id: dto.id,
              groupId: dto.groupId,
              date: DateTime.fromMillisecondsSinceEpoch(dto.dateInMillis));
        },
      );

      onValue.call(result.toList());
    });

    return () => subscription.cancel();
  }

  @override
  Future<List<Match>> getMatches(String groupId) async {
    final value = await _db
        .collection("matches")
        .where("groupId", isEqualTo: groupId)
        .get();
    return value.docs.map((doc) {
      MatchDTO dto = MatchDTO.fromJson(doc.data());
      return Match(
          id: dto.id,
          groupId: dto.groupId,
          date: DateTime.fromMillisecondsSinceEpoch(dto.dateInMillis));
    }).toList();
  }
}
