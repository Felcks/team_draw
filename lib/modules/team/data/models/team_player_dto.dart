import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_player_dto.freezed.dart';
part 'team_player_dto.g.dart';

@freezed
class TeamPlayerDTO with _$TeamPlayerDTO {

  const factory TeamPlayerDTO({
    required String teamId,
    required String playerId,
    required String matchId,
  }) =  _TeamPlayerDTO;

  factory TeamPlayerDTO.fromJson(Map<String, Object?> json)
  => _$TeamPlayerDTOFromJson(json);
}