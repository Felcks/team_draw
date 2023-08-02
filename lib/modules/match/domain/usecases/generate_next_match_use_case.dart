import 'package:team_randomizer/modules/match/domain/repositories/match_repository.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';
import 'package:uuid/uuid.dart';

import '../models/game_date.dart';
import '../../../group/domain/models/group.dart';

abstract class GenerateNextMatchUseCase {
  bool invoke(Group group, DateTime lastMatchDate);
}

class GenerateNextMatchUseCaseImpl extends GenerateNextMatchUseCase {
  MatchRepository matchRepository = MatchRepositoryImpl();

  @override
  bool invoke(Group group, DateTime lastMatchDate) {
    DateTime _groupGameDate = group.date.getNextDate();
    if (lastMatchDate.day == _groupGameDate.day &&
        lastMatchDate.month == _groupGameDate.month &&
        lastMatchDate.year == _groupGameDate.year) return false;

    Match match = Match(id: Uuid().v4(), groupId: group.id, date: _groupGameDate);
    matchRepository.createMatch(match);
    return true;
  }
}
