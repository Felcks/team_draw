import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_randomizer/modules/core/data/database_utils.dart';
import 'package:team_randomizer/modules/game/domain/repositories/group_repository.dart';
import 'package:team_randomizer/modules/game/presentation/group_creation/group_creation.dart';
import 'package:team_randomizer/modules/game/presentation/group_home//group_home_page.dart';
import 'package:team_randomizer/modules/game/presentation/group_list/group_widget.dart';

import '../../domain/models/game_date.dart';
import '../../domain/models/group.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({Key? key}) : super(key: key);

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  GroupRepository gameRepository = GroupRepository();
  List<Group> _groups = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    final FirebaseApp _app = Firebase.app();
    FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: _app,
      databaseURL: "https://team-randomizer-1516f-default-rtdb.europe-west1.firebasedatabase.app/",
    );

    database.ref("group").onValue.listen((event) {
      List<Group> result = List.empty(growable: true);
      event.snapshot.children.forEach((element) {
        Map<Object?, Object?> group = (element.value as Map<Object?, Object?>);
        String? startTime = group["startTime"] as String;
        String? endTime = group["endTime"] as String;
        int weekDay = (group["weekday"] as int);

        result.add(
          Group(
            id: element.key ?? "",
            title: group["title"] as String? ?? "",
            players: List.empty(),
            startTime: TimeOfDay(hour:int.parse(startTime.split(":")[0]),minute: int.parse(startTime.split(":")[1])),
            endTime: TimeOfDay(hour:int.parse(endTime.split(":")[0]),minute: int.parse(endTime.split(":")[1])),
            local: group["local"] as String? ?? "",
            image: "https://lh5.googleusercontent.com/p/AF1QipNczAUhbyQf2koTig0m41v7eShuv8MffbD6YCB8=w650-h486-k-no",
            date: RecurrentDate(weekDay: weekDay),
          ),
        );
      });

      setState(() {
        _groups = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      "Grupos",
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _groups.length + 1,
                  itemBuilder: (context, index) {
                    if (index < _groups.length) {
                      Group group = _groups[index];
                      return GroupWidget(
                        group: group,
                        onClick: (group) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GroupHomePage(
                                group: group,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(32.0),
                              shape: BoxShape.rectangle,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    size: 48,
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => GroupCreation(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
