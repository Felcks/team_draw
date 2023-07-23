// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TeamDTO _$TeamDTOFromJson(Map<String, dynamic> json) {
  return _TeamDTO.fromJson(json);
}

/// @nodoc
mixin _$TeamDTO {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamDTOCopyWith<TeamDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamDTOCopyWith<$Res> {
  factory $TeamDTOCopyWith(TeamDTO value, $Res Function(TeamDTO) then) =
      _$TeamDTOCopyWithImpl<$Res, TeamDTO>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$TeamDTOCopyWithImpl<$Res, $Val extends TeamDTO>
    implements $TeamDTOCopyWith<$Res> {
  _$TeamDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TeamDTOCopyWith<$Res> implements $TeamDTOCopyWith<$Res> {
  factory _$$_TeamDTOCopyWith(
          _$_TeamDTO value, $Res Function(_$_TeamDTO) then) =
      __$$_TeamDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$_TeamDTOCopyWithImpl<$Res>
    extends _$TeamDTOCopyWithImpl<$Res, _$_TeamDTO>
    implements _$$_TeamDTOCopyWith<$Res> {
  __$$_TeamDTOCopyWithImpl(_$_TeamDTO _value, $Res Function(_$_TeamDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$_TeamDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TeamDTO implements _TeamDTO {
  const _$_TeamDTO({required this.id, required this.name});

  factory _$_TeamDTO.fromJson(Map<String, dynamic> json) =>
      _$$_TeamDTOFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'TeamDTO(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TeamDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TeamDTOCopyWith<_$_TeamDTO> get copyWith =>
      __$$_TeamDTOCopyWithImpl<_$_TeamDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TeamDTOToJson(
      this,
    );
  }
}

abstract class _TeamDTO implements TeamDTO {
  const factory _TeamDTO(
      {required final String id, required final String name}) = _$_TeamDTO;

  factory _TeamDTO.fromJson(Map<String, dynamic> json) = _$_TeamDTO.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_TeamDTOCopyWith<_$_TeamDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
