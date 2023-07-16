import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/game/domain/models/game.dart';
import 'package:team_randomizer/modules/game/domain/repositories/game_repository.dart';
import 'package:team_randomizer/modules/game/presentation/game_home/game_home_page.dart';
import 'package:team_randomizer/modules/game/presentation/game_list/game_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../core/data/database_utils.dart';
import '../../domain/models/group.dart';

class GameListPage extends StatefulWidget {
  final Group group;
  const GameListPage({Key? key, required this.group}) : super(key: key);

  @override
  State<GameListPage> createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage> {
  GameRepository gameRepository = GameRepository();

  List<Game> _games = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    final FirebaseApp _app = Firebase.app();
    FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: _app,
      databaseURL: "https://team-randomizer-1516f-default-rtdb.europe-west1.firebasedatabase.app/",
    );

    database.ref("game").onValue.listen((event) {
      List<Game> result = List.empty(growable: true);
      event.snapshot.children.forEach((element) {
        Map<Object?, Object?> game = (element.value as Map<Object?, Object?>);
        result.add(
          Game(
            groupId: (game["groupId"] as String),
            date: DateTime.fromMicrosecondsSinceEpoch(game["date"] as int),
            players: List.empty(),
          ),
        );
      });

      setState(() {
        _games = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Game> games = _games;

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
                      "Partidas",
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
                      Game game = games[index];
                      return GameWidget(
                        game: game,
                        onClick: (game) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GameHomePage(
                                game: game,
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
                                  onPressed: () {
                                    DatabaseReference ref = getDatabase().ref();
                                    ref.child("game").push().set({
                                      "date": DateTime.timestamp().millisecondsSinceEpoch,
                                      "players": widget.group.players.map((e) =>
                                        {
                                          "playerId": e.name,
                                          "status": "NOT_CONFIRMED",
                                        }
                                      ).toList(),
                                      "groupId": widget.group.id,
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: 48,
                                  ),
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
