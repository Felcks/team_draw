import 'package:team_randomizer/modules/core/utils.dart';
import 'package:team_randomizer/modules/match/domain/repositories/match_repository.dart';
import 'package:team_randomizer/modules/match/domain/models/match.dart';
import 'package:uuid/uuid.dart';

import '../../../group/domain/models/group.dart';

abstract class GenerateNextMatchUseCase {
  Future<bool> invoke(Group group);
}

class GenerateNextMatchUseCaseImpl extends GenerateNextMatchUseCase {
  MatchRepository matchRepository = MatchRepositoryImpl();

  @override
  Future<bool> invoke(Group group) async {
    DateTime groupGameDate = group.date.getNextDate();
    bool result = false;

    List<Match> matches = await matchRepository.getMatches(group.id);
    Match match = matches.firstWhere(
        (element) => element.date.isSameDate(groupGameDate), orElse: () {
      Match match =
          Match(id: Uuid().v4(), groupId: group.id, date: groupGameDate);
      matchRepository.createMatch(match);
      result = true;
      return match;
    });

    return result;
  }
}
