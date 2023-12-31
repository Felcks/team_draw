import 'package:flutter/material.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';
import 'package:team_randomizer/modules/match/domain/repositories/match_repository.dart';
import 'package:team_randomizer/modules/match/domain/usecases/generate_next_match_use_case.dart';
import 'package:team_randomizer/modules/match/presentation/match_home/match_home_page.dart';
import 'package:team_randomizer/modules/match/presentation/match_list/match_widget.dart';

import '../../../group/domain/models/group.dart';

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

  Function() _matchUpdateUnregister = () {};

  @override
  void initState() {
    super.initState();

    _matchUpdateUnregister = matchRepository.listenMatches((list) {
      setState(() {
        _matches = list;
      });
    });
  }

  @override
  void dispose() {
    _matchUpdateUnregister.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  itemCount: _matches.length + 1,
                  itemBuilder: (context, index) {
                    if (index < _matches.length) {
                      Match match = _matches[index];
                      return MatchWidget(
                        match: match,
                        onClick: (match) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MatchHomePage(
                                match: match,
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
