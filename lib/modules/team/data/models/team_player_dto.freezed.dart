// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_player_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TeamPlayerDTO _$TeamPlayerDTOFromJson(Map<String, dynamic> json) {
  return _TeamPlayerDTO.fromJson(json);
}

/// @nodoc
mixin _$TeamPlayerDTO {
  String get teamId => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamPlayerDTOCopyWith<TeamPlayerDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamPlayerDTOCopyWith<$Res> {
  factory $TeamPlayerDTOCopyWith(
          TeamPlayerDTO value, $Res Function(TeamPlayerDTO) then) =
      _$TeamPlayerDTOCopyWithImpl<$Res, TeamPlayerDTO>;
  @useResult
  $Res call({String teamId, String playerId});
}

/// @nodoc
class _$TeamPlayerDTOCopyWithImpl<$Res, $Val extends TeamPlayerDTO>
    implements $TeamPlayerDTOCopyWith<$Res> {
  _$TeamPlayerDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? playerId = null,
  }) {
    return _then(_value.copyWith(
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TeamPlayerDTOCopyWith<$Res>
    implements $TeamPlayerDTOCopyWith<$Res> {
  factory _$$_TeamPlayerDTOCopyWith(
          _$_TeamPlayerDTO value, $Res Function(_$_TeamPlayerDTO) then) =
      __$$_TeamPlayerDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String teamId, String playerId});
}

/// @nodoc
class __$$_TeamPlayerDTOCopyWithImpl<$Res>
    extends _$TeamPlayerDTOCopyWithImpl<$Res, _$_TeamPlayerDTO>
    implements _$$_TeamPlayerDTOCopyWith<$Res> {
  __$$_TeamPlayerDTOCopyWithImpl(
      _$_TeamPlayerDTO _value, $Res Function(_$_TeamPlayerDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? playerId = null,
  }) {
    return _then(_$_TeamPlayerDTO(
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TeamPlayerDTO implements _TeamPlayerDTO {
  const _$_TeamPlayerDTO({required this.teamId, required this.playerId});

  factory _$_TeamPlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$$_TeamPlayerDTOFromJson(json);

  @override
  final String teamId;
  @override
  final String playerId;

  @override
  String toString() {
    return 'TeamPlayerDTO(teamId: $teamId, playerId: $playerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TeamPlayerDTO &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, teamId, playerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TeamPlayerDTOCopyWith<_$_TeamPlayerDTO> get copyWith =>
      __$$_TeamPlayerDTOCopyWithImpl<_$_TeamPlayerDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TeamPlayerDTOToJson(
      this,
    );
  }
}

abstract class _TeamPlayerDTO implements TeamPlayerDTO {
  const factory _TeamPlayerDTO(
      {required final String teamId,
      required final String playerId}) = _$_TeamPlayerDTO;

  factory _TeamPlayerDTO.fromJson(Map<String, dynamic> json) =
      _$_TeamPlayerDTO.fromJson;

  @override
  String get teamId;
  @override
  String get playerId;
  @override
  @JsonKey(ignore: true)
  _$$_TeamPlayerDTOCopyWith<_$_TeamPlayerDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
