import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_randomizer/modules/game/domain/repositories/group_repository.dart';
import 'package:team_randomizer/modules/game/presentation/group_home//group_home_page.dart';
import 'package:team_randomizer/modules/game/presentation/group_list/group_widget.dart';

import '../../domain/models/group.dart';

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
                            color: Colors.grey,
                          ),
                          Align(
                            child: Icon(
                              Icons.add,
                              size: 48,
                            ),
                          )
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
