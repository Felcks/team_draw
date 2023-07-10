import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_randomizer/modules/game/domain/models/group.dart';
import 'package:team_randomizer/modules/game/domain/models/player.dart';
import 'package:team_randomizer/modules/game/presentation/game_list/game_list_page.dart';
import 'package:team_randomizer/modules/game/presentation/group_home/new_player_widget.dart';
import 'package:intl/intl.dart';

class GroupHomePage extends StatefulWidget {
  final Group group;

  const GroupHomePage({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupHomePage> createState() => _GroupHomePageState();
}

class _GroupHomePageState extends State<GroupHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: Stack(
                    children: [
                      Image.network(
                        widget.group.image,
                        height: 400,
                        fit: BoxFit.fitHeight,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(4.0),
                            shape: BoxShape.rectangle,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.group.title,
                                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                //TODO ajustar esses layouts de detalhe do campo
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      "Próxima data: ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      formatNextDate(widget.group.date.getNextDate()),
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      widget.group.startTime.format(context) +
                                          " - " +
                                          widget.group.endTime.format(context),
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    ClipRect(
                                        child: Text(
                                      widget.group.local,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                    //TODO substituir com horario
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                        builder: (context) => GameListPage(),
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
                            Text("Partidas", style: TextStyle(fontSize: 24),),
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
              "Jogadores frequentes",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        Column(
          children: List.generate(
            widget.group.players.length,
            (index) {
              Player player = widget.group.players[index];
              return NewPlayerWidget(player: player);
            },
          ),
        )
      ],
    );
  }
}
