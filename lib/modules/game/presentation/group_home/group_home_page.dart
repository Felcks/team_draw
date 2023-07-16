import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_randomizer/modules/core/data/database_utils.dart';
import 'package:team_randomizer/modules/game/domain/models/group.dart';
import 'package:team_randomizer/modules/game/domain/models/player.dart';
import 'package:team_randomizer/modules/game/presentation/game_list/game_list_page.dart';
import 'package:team_randomizer/modules/game/presentation/group_home/new_player_widget.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class GroupHomePage extends StatefulWidget {
  final Group group;

  const GroupHomePage({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupHomePage> createState() => _GroupHomePageState();
}

class _GroupHomePageState extends State<GroupHomePage> {
  List<Player> _players = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    final FirebaseApp _app = Firebase.app();
    FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: _app,
      databaseURL: "https://team-randomizer-1516f-default-rtdb.europe-west1.firebasedatabase.app/",
    );

    database.ref("player").onValue.listen((event) {
      List<Player> result = List.empty(growable: true);
      event.snapshot.children.where((element) => (element.value as Map<Object?, Object?>)["groupId"] == widget.group.id).forEach((element) {
        Map<Object?, Object?> player = (element.value as Map<Object?, Object?>);
        result.add(
          Player(
            groupId: (player["groupId"] as String),
            id: element.key.toString(),
            name: (player["name"] as String),
            overall: (player["overall"] as int),
          ),
        );
      });

      setState(() {
        _players = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 400,
              child: Image.network(
                widget.group.image,
                height: 400,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 300,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                shape: BoxShape.rectangle,
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        width: 60,
                        child: Divider(
                          color: Colors.black,
                          height: 1,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.group.title,
                      style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      //TODO ajustar esses layouts de detalhe do campo
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            "Próxima data: ",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            formatNextDate(widget.group.date.getNextDate()),
                            style: TextStyle(color: Colors.black),
                          ),
                          //TODO substituir com data correta do jogo
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            "Horário: ",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            widget.group.startTime.format(context) + " - " + widget.group.endTime.format(context),
                            style: TextStyle(color: Colors.black),
                          ),
                          //TODO substituir com horario correto
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            "Local: ",
                            style: TextStyle(color: Colors.black),
                          ),
                          ClipRect(
                              child: Text(
                            widget.group.local,
                            style: TextStyle(color: Colors.black),
                          )),
                          //TODO substituir com horario
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: groupActions(),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: frequentPlayers(),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String formatNextDate(DateTime value) {
    return DateFormat('EEEE (dd/MM)').format(value);
  }

  //TODO transform in a configurable options
  //TODO move to another file
  Widget groupActions() {
    return Column(
      children: List.generate(
        1,
        (index) => SizedBox(
          height: 150,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GameListPage(
                          group: widget.group,
                          players: _players,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(32.0),
                          shape: BoxShape.rectangle,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                      //Align(alignment: Alignment.center,)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/football-field.png"),
                            Text(
                              "Partidas",
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget frequentPlayers() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Jogadores",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Column(
          children: List.generate(
            _players.length + 1,
            (index) {
              if (index < _players.length) {
                Player player = _players[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NewPlayerWidget(player: player),
                  ],
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey.withOpacity(0.1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 48,
                            ),
                            onPressed: () {
                              DatabaseReference ref = getDatabase().ref();
                              ref.child("player").push().set(
                                {
                                  "name": "Matheus Felipe",
                                  "overall": 100,
                                  "groupId": widget.group.id,
                                },
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
        )
      ],
    );
  }
}
