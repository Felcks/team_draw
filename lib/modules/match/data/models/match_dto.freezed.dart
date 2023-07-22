// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MatchDTO _$MatchDTOFromJson(Map<String, dynamic> json) {
  return _MatchDTO.fromJson(json);
}

/// @nodoc
mixin _$MatchDTO {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  int get dateInMillis => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchDTOCopyWith<MatchDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchDTOCopyWith<$Res> {
  factory $MatchDTOCopyWith(MatchDTO value, $Res Function(MatchDTO) then) =
      _$MatchDTOCopyWithImpl<$Res, MatchDTO>;
  @useResult
  $Res call({String id, String groupId, int dateInMillis});
}

/// @nodoc
class _$MatchDTOCopyWithImpl<$Res, $Val extends MatchDTO>
    implements $MatchDTOCopyWith<$Res> {
  _$MatchDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? dateInMillis = null,
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
      dateInMillis: null == dateInMillis
          ? _value.dateInMillis
          : dateInMillis // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MatchDTOCopyWith<$Res> implements $MatchDTOCopyWith<$Res> {
  factory _$$_MatchDTOCopyWith(
          _$_MatchDTO value, $Res Function(_$_MatchDTO) then) =
      __$$_MatchDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String groupId, int dateInMillis});
}

/// @nodoc
class __$$_MatchDTOCopyWithImpl<$Res>
    extends _$MatchDTOCopyWithImpl<$Res, _$_MatchDTO>
    implements _$$_MatchDTOCopyWith<$Res> {
  __$$_MatchDTOCopyWithImpl(
      _$_MatchDTO _value, $Res Function(_$_MatchDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? dateInMillis = null,
  }) {
    return _then(_$_MatchDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      dateInMillis: null == dateInMillis
          ? _value.dateInMillis
          : dateInMillis // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MatchDTO implements _MatchDTO {
  const _$_MatchDTO(
      {required this.id, required this.groupId, required this.dateInMillis});

  factory _$_MatchDTO.fromJson(Map<String, dynamic> json) =>
      _$$_MatchDTOFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final int dateInMillis;

  @override
  String toString() {
    return 'MatchDTO(id: $id, groupId: $groupId, dateInMillis: $dateInMillis)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MatchDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.dateInMillis, dateInMillis) ||
                other.dateInMillis == dateInMillis));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, groupId, dateInMillis);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MatchDTOCopyWith<_$_MatchDTO> get copyWith =>
      __$$_MatchDTOCopyWithImpl<_$_MatchDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MatchDTOToJson(
      this,
    );
  }
}

abstract class _MatchDTO implements MatchDTO {
  const factory _MatchDTO(
      {required final String id,
      required final String groupId,
      required final int dateInMillis}) = _$_MatchDTO;

  factory _MatchDTO.fromJson(Map<String, dynamic> json) = _$_MatchDTO.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  int get dateInMillis;
  @override
  @JsonKey(ignore: true)
  _$$_MatchDTOCopyWith<_$_MatchDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
