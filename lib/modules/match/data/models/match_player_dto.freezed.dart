// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_player_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MatchPlayerDTO _$MatchPlayerDTOFromJson(Map<String, dynamic> json) {
  return _MatchPlayerDTO.fromJson(json);
}

/// @nodoc
mixin _$MatchPlayerDTO {
  String get matchId => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchPlayerDTOCopyWith<MatchPlayerDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchPlayerDTOCopyWith<$Res> {
  factory $MatchPlayerDTOCopyWith(
          MatchPlayerDTO value, $Res Function(MatchPlayerDTO) then) =
      _$MatchPlayerDTOCopyWithImpl<$Res, MatchPlayerDTO>;
  @useResult
  $Res call({String matchId, String playerId, String status});
}

/// @nodoc
class _$MatchPlayerDTOCopyWithImpl<$Res, $Val extends MatchPlayerDTO>
    implements $MatchPlayerDTOCopyWith<$Res> {
  _$MatchPlayerDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = null,
    Object? playerId = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MatchPlayerDTOCopyWith<$Res>
    implements $MatchPlayerDTOCopyWith<$Res> {
  factory _$$_MatchPlayerDTOCopyWith(
          _$_MatchPlayerDTO value, $Res Function(_$_MatchPlayerDTO) then) =
      __$$_MatchPlayerDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String matchId, String playerId, String status});
}

/// @nodoc
class __$$_MatchPlayerDTOCopyWithImpl<$Res>
    extends _$MatchPlayerDTOCopyWithImpl<$Res, _$_MatchPlayerDTO>
    implements _$$_MatchPlayerDTOCopyWith<$Res> {
  __$$_MatchPlayerDTOCopyWithImpl(
      _$_MatchPlayerDTO _value, $Res Function(_$_MatchPlayerDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = null,
    Object? playerId = null,
    Object? status = null,
  }) {
    return _then(_$_MatchPlayerDTO(
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MatchPlayerDTO implements _MatchPlayerDTO {
  const _$_MatchPlayerDTO(
      {required this.matchId, required this.playerId, required this.status});

  factory _$_MatchPlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$$_MatchPlayerDTOFromJson(json);

  @override
  final String matchId;
  @override
  final String playerId;
  @override
  final String status;

  @override
  String toString() {
    return 'MatchPlayerDTO(matchId: $matchId, playerId: $playerId, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MatchPlayerDTO &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, matchId, playerId, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MatchPlayerDTOCopyWith<_$_MatchPlayerDTO> get copyWith =>
      __$$_MatchPlayerDTOCopyWithImpl<_$_MatchPlayerDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MatchPlayerDTOToJson(
      this,
    );
  }
}

abstract class _MatchPlayerDTO implements MatchPlayerDTO {
  const factory _MatchPlayerDTO(
      {required final String matchId,
      required final String playerId,
      required final String status}) = _$_MatchPlayerDTO;

  factory _MatchPlayerDTO.fromJson(Map<String, dynamic> json) =
      _$_MatchPlayerDTO.fromJson;

  @override
  String get matchId;
  @override
  String get playerId;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$_MatchPlayerDTOCopyWith<_$_MatchPlayerDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
