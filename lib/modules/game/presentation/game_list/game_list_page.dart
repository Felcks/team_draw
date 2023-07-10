import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/game/domain/models/game.dart';
import 'package:team_randomizer/modules/game/domain/repositories/game_repository.dart';
import 'package:team_randomizer/modules/game/presentation/game_home/game_home_page.dart';
import 'package:team_randomizer/modules/game/presentation/game_list/game_widget.dart';

class GameListPage extends StatefulWidget {
  const GameListPage({Key? key}) : super(key: key);

  @override
  State<GameListPage> createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage> {
  GameRepository gameRepository = GameRepository();

  @override
  Widget build(BuildContext context) {
    List<Game> games = gameRepository.getGames();

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
                                Icon(
                                  Icons.add,
                                  size: 48,
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
