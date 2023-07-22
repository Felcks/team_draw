import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';
import 'package:team_randomizer/modules/match/domain/repositories/match_repository.dart';
import 'package:team_randomizer/modules/match/domain/usecases/generate_next_match_use_case.dart';
import 'package:team_randomizer/modules/match/presentation/match_list/match_widget.dart';

import '../../../game/domain/models/group.dart';

class MatchListPage extends StatefulWidget {
  final Group group;
  const MatchListPage({Key? key, required this.group}) : super(key: key);

  @override
  State<MatchListPage> createState() => _MatchListPageState();
}

class _MatchListPageState extends State<MatchListPage> {

  MatchRepository matchRepository = MatchRepositoryImpl();
  GenerateNextMatchUseCase _generateNextMatchUseCase = GenerateNextMatchUseCaseImpl();

  List<Match> _matches = List.empty(growable: true);

  Function() _unsubscriber = () {};

  @override
  void initState() {
    super.initState();

    _unsubscriber = matchRepository.listenMatches((list) {
      setState(() {
        _matches = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Match> matches = _matches;

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
                  itemCount: matches.length + 1,
                  itemBuilder: (context, index) {
                    if (index < matches.length) {
                      Match match = matches[index];
                      return MatchWidget(
                        match: match,
                        onClick: (match) {
                          /*Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GameHomePage(
                                game: game,
                              ),
                            ),
                          );*/
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
                                    _generateNextMatchUseCase.invoke(widget.group, _matches.lastOrNull?.date ?? DateTime.now());
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
