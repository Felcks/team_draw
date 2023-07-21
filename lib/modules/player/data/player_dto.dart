
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_dto.freezed.dart';
part 'player_dto.g.dart';

@freezed
class PlayerDTO with _$PlayerDTO {

  const factory PlayerDTO({
    required String id,
    required String groupId,
    required String name,
    required int overall,
}) = _PlayerDTO;

  factory PlayerDTO.fromJson(Map<String, Object?> json)
  => _$PlayerDTOFromJson(json);
}