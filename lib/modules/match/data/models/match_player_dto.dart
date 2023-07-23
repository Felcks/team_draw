
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_player_dto.freezed.dart';
part 'match_player_dto.g.dart';

@freezed
class MatchPlayerDTO with _$MatchPlayerDTO {

  const factory MatchPlayerDTO({
    required String matchId,
    required String playerId,
    required String status,
  }) =  _MatchPlayerDTO;

  factory MatchPlayerDTO.fromJson(Map<String, Object?> json)
  => _$MatchPlayerDTOFromJson(json);
}