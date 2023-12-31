import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/group/presentation/group_creation/group_creation.dart';
import 'package:team_randomizer/modules/group/presentation/group_home/group_home_page.dart';
import 'package:team_randomizer/modules/group/presentation/group_list/group_widget.dart';
import 'package:team_randomizer/modules/group/domain/repositories/group_repository.dart';

import '../../domain/models/group.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({Key? key}) : super(key: key);

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  List<Group> _groups = List.empty(growable: true);

  GroupRepositoryImpl repositoryImpl = GroupRepositoryImpl();

  Function() _groupListUnregister = () {};

  @override
  void initState() {
    super.initState();

    _groupListUnregister = repositoryImpl.listenGroups((list) {
      setState(() {
        print(list);
        _groups = list;
      });
    });
  }

  @override
  void dispose() {
    _groupListUnregister.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Grupos",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: _groupList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _groupList() {
    return GridView.builder(
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
          return _createGroupWidget();
        }
      },
    );
  }

  Widget _createGroupWidget() {
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
}
