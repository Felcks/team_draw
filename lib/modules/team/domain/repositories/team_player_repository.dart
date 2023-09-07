import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_randomizer/modules/player/domain/player_repository.dart';
import 'package:team_randomizer/modules/team/domain/repositories/team_repository.dart';

import '../../../player/domain/player.dart';
import '../../data/models/team_player_dto.dart';
import '../models/team.dart';
import '../models/team_player.dart';

abstract class TeamPlayerRepository {
  void createTeamPlayer(TeamPlayer input);

  void editTeamPlayer(TeamPlayer input);

  void deleteTeamPlayer(TeamPlayer input);

  void Function() listenTeamPlayers(String groupId, String matchId, onValue(List<TeamPlayer> list));
}

class TeamPlayerRepositoryImpl extends TeamPlayerRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  TeamRepository teamRepository = TeamRepositoryImpl();
  PlayerRepository playerRepository = PlayerRepositoryImpl();

  @override
  void createTeamPlayer(TeamPlayer input) {
    TeamPlayerDTO dto = TeamPlayerDTO(playerId: input.player.id, teamId: input.team.id, matchId: input.matchId);

    _db.collection("team_player").add(dto.toJson()).then((value) => print("DocumentId ${value.id}"));
  }

  @override
  void editTeamPlayer(TeamPlayer input) {
    TeamPlayerDTO dto = TeamPlayerDTO(playerId: input.player.id, teamId: input.team.id, matchId: input.matchId);
    _db.collection("team_player").where("playerId", isEqualTo: dto.playerId).where("teamId", isEqualTo: dto.teamId).get().then(
          (value) {
        _db.collection("team_player").doc(value.docs.first.id).update(dto.toJson());
      },
    );
  }

  @override
  void deleteTeamPlayer(TeamPlayer input) {
    TeamPlayerDTO dto = TeamPlayerDTO(playerId: input.player.id, teamId: input.team.id, matchId: input.matchId);

    _db.collection("team_player").where("teamId", isEqualTo: dto.teamId).where("playerId", isEqualTo: dto.playerId).get().then((value) {
      _db.collection("team_player").doc(value.docs.first.id).delete();
    });
  }

  @override
  void Function() listenTeamPlayers(String groupId, String matchId, Function(List<TeamPlayer> list) onValue) {
    final subscription = _db.collection("team_player").where("matchId", isEqualTo: matchId).snapshots().listen((event) async {
      final players = await playerRepository.getPlayers(groupId);
      final teams = await teamRepository.getTeams();
      final result = event.docs.map(
            (doc) {
          TeamPlayerDTO dto = TeamPlayerDTO.fromJson(
            doc.data(),
          );

          Player player = players.firstWhere((element) => element.id == dto.playerId);
          if(!teams.map((e) => e.id).contains(dto.teamId)) {
            return TeamPlayer(
              player: player,
              team: teams.first,
              matchId: dto.matchId,
            );
          }

          Team team = teams.firstWhere((element) => element.id == dto.teamId);

          return TeamPlayer(
            player: player,
            team: team,
            matchId: dto.matchId,
          );
        },
      );

      onValue.call(result.toList());
    });

    return () => subscription.cancel();
  }
}
