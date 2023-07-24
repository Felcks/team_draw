import 'package:team_randomizer/modules/match/domain/repositories/match_repository.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';
import 'package:uuid/uuid.dart';

import '../models/game_date.dart';
import '../../../group/domain/models/group.dart';

abstract class GenerateNextMatchUseCase {
  void invoke(Group group, DateTime lastMatchDate);
}

class GenerateNextMatchUseCaseImpl extends GenerateNextMatchUseCase {

  MatchRepository matchRepository = MatchRepositoryImpl();

  @override
  void invoke(Group group, DateTime lastMatchDate) {
    DateTime _nextMatchDate = lastMatchDate;

    GameDate _groupGameDate = group.date;
    while(_nextMatchDate.weekday != _groupGameDate.weekDay){
      _nextMatchDate = _nextMatchDate.add(Duration(days: 1));
    }
    Match match = Match(id: Uuid().v4(), groupId: group.id, date: _nextMatchDate);

    matchRepository.createMatch(match);
  }

}

