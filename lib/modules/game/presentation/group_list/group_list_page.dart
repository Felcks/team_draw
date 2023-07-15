import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_randomizer/modules/core/data/database_utils.dart';
import 'package:team_randomizer/modules/game/domain/repositories/group_repository.dart';
import 'package:team_randomizer/modules/game/presentation/group_creation/group_creation.dart';
import 'package:team_randomizer/modules/game/presentation/group_home//group_home_page.dart';
import 'package:team_randomizer/modules/game/presentation/group_list/group_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    List<Group> games = gameRepository.getGroupList();

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
              TextButton(
                  onPressed: () async {
                    final FirebaseApp _app = Firebase.app();
                    FirebaseDatabase database = FirebaseDatabase.instanceFor(
                        app: _app,
                        databaseURL: "https://team-randomizer-1516f-default-rtdb.europe-west1.firebasedatabase.app/");

                    final ref = database.ref();
                    final snapshot = await ref.child('group/-N_5VFG5GI2tjUUtdRQS').get();
                    if (snapshot.exists) {
                      print(snapshot.value);
                    } else {
                      print('No data available.');
                    }
                  },
                  child: Text("Read value")),
              Expanded(
                flex: 10,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: games.length + 1,
                  itemBuilder: (context, index) {
                    if (index < games.length) {
                      Group game = games[index];
                      return GroupWidget(
                        group: game,
                        onClick: (game) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GroupHomePage(
                                group: game,
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
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => GroupCreation(),
                                    ));

                                    /*DatabaseReference ref = getDatabase().ref();
                                    // https://console.firebase.google.com/u/0/project/team-randomizer-1516f/database/team-randomizer-1516f-default-rtdb/data/~2F
                                    // https://firebase.google.com/docs/database/flutter/read-and-write

                                    await ref.child("group").push().set({
                                      "title": "Craques da bola",
                                      "local": "Campo de Areeiro 2"
                                    });*/
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
