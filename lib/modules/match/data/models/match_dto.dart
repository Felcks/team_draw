
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_dto.freezed.dart';
part 'match_dto.g.dart';

@freezed
class MatchDTO with _$MatchDTO {

  const factory MatchDTO({
    required String id,
    required String groupId,
    required int dateInMillis,
}) =  _MatchDTO;

  factory MatchDTO.fromJson(Map<String, Object?> json)
  => _$MatchDTOFromJson(json);
}
