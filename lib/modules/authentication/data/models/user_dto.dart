import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDTO with  _$UserDTO {

  const factory UserDTO({
    required String id,
    required String authenticationId,
    required String name,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, Object?> json)
  => _$UserDTOFromJson(json);
}