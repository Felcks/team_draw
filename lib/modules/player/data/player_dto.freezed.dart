// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayerDTO _$PlayerDTOFromJson(Map<String, dynamic> json) {
  return _PlayerDTO.fromJson(json);
}

/// @nodoc
mixin _$PlayerDTO {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get overall => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerDTOCopyWith<PlayerDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerDTOCopyWith<$Res> {
  factory $PlayerDTOCopyWith(PlayerDTO value, $Res Function(PlayerDTO) then) =
      _$PlayerDTOCopyWithImpl<$Res, PlayerDTO>;
  @useResult
  $Res call({String id, String groupId, String name, int overall});
}

/// @nodoc
class _$PlayerDTOCopyWithImpl<$Res, $Val extends PlayerDTO>
    implements $PlayerDTOCopyWith<$Res> {
  _$PlayerDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? name = null,
    Object? overall = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      overall: null == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayerDTOCopyWith<$Res> implements $PlayerDTOCopyWith<$Res> {
  factory _$$_PlayerDTOCopyWith(
          _$_PlayerDTO value, $Res Function(_$_PlayerDTO) then) =
      __$$_PlayerDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String groupId, String name, int overall});
}

/// @nodoc
class __$$_PlayerDTOCopyWithImpl<$Res>
    extends _$PlayerDTOCopyWithImpl<$Res, _$_PlayerDTO>
    implements _$$_PlayerDTOCopyWith<$Res> {
  __$$_PlayerDTOCopyWithImpl(
      _$_PlayerDTO _value, $Res Function(_$_PlayerDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? name = null,
    Object? overall = null,
  }) {
    return _then(_$_PlayerDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      overall: null == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayerDTO implements _PlayerDTO {
  const _$_PlayerDTO(
      {required this.id,
      required this.groupId,
      required this.name,
      required this.overall});

  factory _$_PlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$$_PlayerDTOFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String name;
  @override
  final int overall;

  @override
  String toString() {
    return 'PlayerDTO(id: $id, groupId: $groupId, name: $name, overall: $overall)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayerDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.overall, overall) || other.overall == overall));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, groupId, name, overall);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerDTOCopyWith<_$_PlayerDTO> get copyWith =>
      __$$_PlayerDTOCopyWithImpl<_$_PlayerDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayerDTOToJson(
      this,
    );
  }
}

abstract class _PlayerDTO implements PlayerDTO {
  const factory _PlayerDTO(
      {required final String id,
      required final String groupId,
      required final String name,
      required final int overall}) = _$_PlayerDTO;

  factory _PlayerDTO.fromJson(Map<String, dynamic> json) =
      _$_PlayerDTO.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get name;
  @override
  int get overall;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerDTOCopyWith<_$_PlayerDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
