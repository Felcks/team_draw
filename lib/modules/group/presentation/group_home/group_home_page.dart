import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:team_randomizer/modules/group/domain/models/group.dart';
import 'package:team_randomizer/modules/player/domain/player.dart';
import 'package:team_randomizer/modules/match/presentation/match_list/match_list_page.dart';
import 'package:team_randomizer/modules/player/presentation/new_player_widget.dart';
import 'package:intl/intl.dart';
import 'package:team_randomizer/modules/player/domain/player_repository.dart';

import '../../../player/presentation/player_creation/player_creation.dart';

class GroupHomePage extends StatefulWidget {
  final Group group;

  const GroupHomePage({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupHomePage> createState() => _GroupHomePageState();
}

class _GroupHomePageState extends State<GroupHomePage> {
  List<Player> _players = List.empty(growable: true);

  final PlayerRepositoryImpl _playerRepository = PlayerRepositoryImpl();

  Function() _playerUpdateUnregister = () {};

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    _playerUpdateUnregister = _playerRepository.listenPlayers(widget.group.id, (list) {
      setState(() {
        _players = list;
      });
    });
  }

  @override
  void dispose() {
    _playerUpdateUnregister.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double startOfCard = ((MediaQuery.of(context).size.width * 9) / 16) * 0.9;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.group.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              left: 16,
              top: 32,
              child: IconButton(
                iconSize: 32,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
          Positioned(
            top: startOfCard,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - startOfCard,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                shape: BoxShape.rectangle,
                color: Theme.of(context).colorScheme.surface,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                        width: 60,
                        child: Divider(
                          color: Colors.black,
                          height: 1,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.group.title,
                      style: const TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Text(
                            "Próxima data: ",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          Text(
                            _formatNextDate(widget.group.date.getNextDate()),
                            style: const TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          //TODO substituir com data correta do jogo
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Text(
                            "Horário: ",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          Text(
                            widget.group.startTime.format(context) + " - " + widget.group.endTime.format(context),
                            style: const TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Text(
                            "Local: ",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          ClipRect(
                            child: Text(
                              widget.group.local,
                              style: const TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: groupActions(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _groupPlayersWidget(),
                    ),
                    const SizedBox(
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
                child: Card(
                  child: InkWell(
                    onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MatchListPage(
                              group: widget.group,
                            ),
                          ),
                        );
                      },
                    child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          //Align(alignment: Alignment.center,)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset("assets/football-field.png"),
                                const Text(
                                  "Partidas",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _groupPlayersWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              "Jogadores",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(
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
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PlayerCreationPage(
                              group: widget.group,
                              player: player,
                            ),
                          ),
                        );
                      },
                      child: NewPlayerWidget(player: player),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                size: 48,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PlayerCreationPage(
                                      group: widget.group,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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

  String _formatNextDate(DateTime value) {
    return DateFormat('EEEE (dd/MM)').format(value);
  }
}
