import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:team_randomizer/main.dart';
import 'package:team_randomizer/modules/authentication/presentation/login/login_page.dart';
import 'package:team_randomizer/modules/core/window_size_class.dart';
import 'package:team_randomizer/modules/group/presentation/group_creation/group_creation.dart';
import 'package:team_randomizer/modules/group/presentation/group_home/group_home_page.dart';
import 'package:team_randomizer/modules/group/presentation/group_list/group_widget.dart';
import 'package:team_randomizer/modules/group/domain/repositories/group_repository.dart';

import '../../../authentication/domain/repositories/user_repository.dart';
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
    initializeDateFormatting();

    _groupListUnregister = repositoryImpl.listenGroups((list) {
      setState(() {
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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: false,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: TextButton(
                child: const Text(
                  "Invisible",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                onPressed: () {},
              ),
            ),
            const Text(
              "Grupos",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextButton(
              child: const Text(
                "Sair",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              onPressed: () async {
                loggedUser = null;
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                    (r) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: _groupList(),
            ),
          ],
        ),
      ),
    );
  }



  Widget _groupList() {
    WindowSizeClass widthSizeClass = getWidthWindowSizeClass(context);
    int rows = 1;
    if(widthSizeClass == WindowSizeClass.MEDIUM) {
      rows = 1;
    } else if(widthSizeClass == WindowSizeClass.EXPANDED) {
      rows = 1;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rows,
        crossAxisSpacing: 2,
        mainAxisSpacing: 4,
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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const GroupCreation(),
          ),
        );
      },
      child: Card(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                shape: BoxShape.rectangle,
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  size: 48,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
