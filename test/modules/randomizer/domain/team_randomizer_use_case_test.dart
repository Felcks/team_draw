import 'package:flutter_test/flutter_test.dart';
import 'package:team_randomizer/modules/game/domain/models/player.dart';
import 'package:team_randomizer/modules/randomizer/domain/models/team.dart';
import 'package:team_randomizer/modules/randomizer/domain/usecases/team_randomizer_use_case.dart';

void main() {

  late TeamRandomizerUseCase sut;

  setUp(() {
    sut = TeamRandomizerTrivialImpl();
  });

  test("given 10 players and two teams, generate two teams with five players each", () {
    List<Player> players = List.generate(10, (index) => Player(id: "", groupId: "", name: "Player $index", overall: index));
    TeamRandomizerUseCaseParameters config = TeamRandomizerUseCaseParameters(teamsAmount: 2, playersInEachTeam: 5);

    List<Team> result = sut.invoke(players, config);

    expect(result.length, 2);
    expect(result.first.players.length, 5);
    expect(result.last.players.length, 5);
  });

  test("given 10 players two teams and leftOverPlayers EXTRA_TEAM, generate two teams with five players each", () {
    List<Player> players = List.generate(10, (index) => Player(id: "", groupId: "", name: "Player $index", overall: index));
    TeamRandomizerUseCaseParameters config = TeamRandomizerUseCaseParameters(teamsAmount: 2, playersInEachTeam: 5, leftoverPlayersAction: LeftoverPlayersAction.EXTRA_TEAM);

    List<Team> result = sut.invoke(players, config);

    expect(result.length, 2);
    expect(result.first.players.length, 5);
    expect(result.last.players.length, 5);
  });

  test("given 12 players two teams and leftOverPlayers EXTRA_TEAM, generate two teams with five players each and one extra team with 2", () {
    List<Player> players = List.generate(12, (index) => Player(id: "", groupId: "", name: "Player $index", overall: index));
    TeamRandomizerUseCaseParameters config = TeamRandomizerUseCaseParameters(teamsAmount: 2, playersInEachTeam: 5, leftoverPlayersAction: LeftoverPlayersAction.EXTRA_TEAM);

    List<Team> result = sut.invoke(players, config);
    expect(result.length, 3);
    expect(result[0].players.length, 5);
    expect(result[1].players.length, 5);
    expect(result[2].players.length, 2);
  });

  test("given 10 players two teams and leftOverPlayers BENCH, generate two teams with five players each", () {
    List<Player> players = List.generate(10, (index) => Player(id: "", groupId: "", name: "Player $index", overall: index));
    TeamRandomizerUseCaseParameters config = TeamRandomizerUseCaseParameters(teamsAmount: 2, playersInEachTeam: 5, leftoverPlayersAction: LeftoverPlayersAction.BENCH);

    List<Team> result = sut.invoke(players, config);

    expect(result.length, 2);
    expect(result.first.players.length, 5);
    expect(result.last.players.length, 5);
  });

  test("given 12 players two teams and leftOverPlayers BENCH, generate two teams with six players", () {
    List<Player> players = List.generate(12, (index) => Player(id: "", groupId: "", name: "Player $index", overall: index));
    TeamRandomizerUseCaseParameters config = TeamRandomizerUseCaseParameters(teamsAmount: 2, playersInEachTeam: 5, leftoverPlayersAction: LeftoverPlayersAction.BENCH);

    List<Team> result = sut.invoke(players, config);
    expect(result.length, 2);
    expect(result[0].players.length, 6);
    expect(result[1].players.length, 6);
  });
}