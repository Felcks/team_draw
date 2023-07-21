import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/game/domain/models/game_date.dart';
import 'package:team_randomizer/modules/game/domain/repositories/player_repository.dart';

import '../models/group.dart';

class GroupRepository {

  List<Group> getGroupList() {
    return _groupList;
  }

  List<Group> _groupList = [
    Group(
      id: "",
        title: "Craques da bola",
        startTime: TimeOfDay(hour: 19, minute: 0),
        endTime: TimeOfDay(hour: 21, minute: 0),
        local: "Campo Areeiro",
        image: "https://lh5.googleusercontent.com/p/AF1QipNczAUhbyQf2koTig0m41v7eShuv8MffbD6YCB8=w650-h486-k-no",
        date: GameDate(weekDay: 4)
    ),
    Group(
        id: "",
        title: "Futebol de Segunda",
        startTime: TimeOfDay(hour: 20, minute: 30),
        endTime: TimeOfDay(hour: 22, minute: 30),
        local: "Campo Telheiras",
        image: "https://static.mygon.com/ImageAdapterV2/shop/17403/shopimage_1.jpg?width=760&height=506",
        date: GameDate(weekDay: 1)
    )
  ];
}