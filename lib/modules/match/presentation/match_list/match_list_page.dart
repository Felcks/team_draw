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

    _matchUpdateUnregister = matchRepository.listenMatches(widget.group.id, (list) {
      setState(() {
        list.sort((a, b) => b.date.compareTo(a.date));
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
      appBar: AppBar(
        title: const Text(
          "Partidas",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      return Card(
                        child: InkWell(
                          onTap: () async {
                            bool result = await _generateNextMatchUseCase.invoke(
                                widget.group, _matches.firstOrNull?.date ?? DateTime.now()
                            );

                            if (result == false) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text("Já existe partida em andamento")));
                            }
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 48,
                              ),
                              Text("Gerar partida")
                            ],
                          ),
                        ),
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
