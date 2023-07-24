import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/match/domain/models/game_date.dart';
import 'package:team_randomizer/modules/group/domain/models/group.dart';
import 'package:team_randomizer/modules/group/data/group_dto.dart';

import '../../../core/utils.dart';

//https://github.com/mojaloop/contrib-pisp-demo-ui/blob/159e00af982d4cdc217d5539ab4897cb7dd9bb90/lib/repositories/firebase/account_repository.dart#L21

abstract class GroupRepository {
  void createGroup(Group group);

  void editGroup(Group group);

  void Function() listenGroups(onValue(List<Group> list));
}

class GroupRepositoryImpl extends GroupRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> createGroup(Group group) async {
    GroupDTO dto = GroupDTO(
      id: group.id,
      title: group.title,
      local: group.local,
      image: group.image,
      startTime: TimeOfDayToString(group.startTime),
      endTime: TimeOfDayToString(group.endTime),
      weekDay: group.date.weekDay,
    );

    _db
        .collection("groups")
        .add(dto.toJson())
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  @override
  void editGroup(Group group) {
    // TODO: implement editGroup
  }

  @override
  void Function() listenGroups(onValue(List<Group> list)) {
    final subscription = _db.collection("groups").snapshots().listen((event) {
    final result = event.docs.map((doc) {
          GroupDTO groupDTO = GroupDTO.fromJson(doc.data());
          return Group(
            id: groupDTO.id,
            title: groupDTO.title,
            startTime: TimeOfDay(
                hour: int.parse(groupDTO.startTime.split(":")[0]),
                minute: int.parse(groupDTO.startTime.split(":")[1])),
            endTime: TimeOfDay(
                hour: int.parse(groupDTO.endTime.split(":")[0]), minute: int.parse(groupDTO.endTime.split(":")[1])),
            local: groupDTO.local,
            image: "https://lh5.googleusercontent.com/p/AF1QipNczAUhbyQf2koTig0m41v7eShuv8MffbD6YCB8=w650-h486-k-no",
            date: GameDate(weekDay: groupDTO.weekDay),
          );
        },
      );

      onValue.call(result.toList());
    });

    return () => subscription.cancel();
  }
}
