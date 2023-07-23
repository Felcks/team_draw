import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/team_dto.dart';
import '../models/team.dart';

abstract class TeamRepository {
  void createTeam(Team input);

  void editTeam(Team input);

  void Function() listenTeams(onValue(List<Team> list));

  Future<List<Team>> getTeams();
}

class TeamRepositoryImpl extends TeamRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void createTeam(Team input) {
    TeamDTO dto = TeamDTO(
      id: input.id,
      name: input.name,
    );

    _db
        .collection("teams")
        .add(dto.toJson())
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  @override
  void editTeam(Team input) {
    TeamDTO dto = TeamDTO(
      id: input.id,
      name: input.name,
    );

    _db
        .collection("teams")
        .add(dto.toJson())
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  @override
  void Function() listenTeams(Function(List<Team> list) onValue) {
    final subscription = _db.collection("teams").snapshots().listen((event) {
      final result = event.docs.map(
        (doc) {
          TeamDTO dto = TeamDTO.fromJson(doc.data());
          return Team(id: dto.id, name: dto.name);
        },
      );

      onValue.call(result.toList());
    });

    return () => subscription.cancel();
  }

  @override
  Future<List<Team>> getTeams() async {
    final value = await _db.collection("teams").get();
    return value.docs.map((doc) {
      TeamDTO dto = TeamDTO.fromJson(doc.data());
      return Team(
        id: dto.id,
        name: dto.name,
      );
    }).toList();
  }
}
