import 'package:team_randomizer/modules/core/utils.dart';
import 'package:team_randomizer/modules/match/domain/repositories/match_repository.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';
import 'package:uuid/uuid.dart';

import '../../../group/domain/models/group.dart';

abstract class GenerateNextMatchUseCase {
  Future<bool> invoke(Group group, DateTime lastMatchDate);
}

class GenerateNextMatchUseCaseImpl extends GenerateNextMatchUseCase {
  MatchRepository matchRepository = MatchRepositoryImpl();

  @override
  Future<bool> invoke(Group group, DateTime lastMatchDate) async {
    DateTime _groupGameDate = group.date.getNextDate();
    bool result = false;

    List<Match> matches = await matchRepository.getMatches(group.id);
    Match match = matches.firstWhere(
        (element) => element.date.isSameDate(lastMatchDate), orElse: () {
      Match match =
          Match(id: Uuid().v4(), groupId: group.id, date: _groupGameDate);
      matchRepository.createMatch(match);
      result = true;
      return match;
    });

    return result;
  }
}
