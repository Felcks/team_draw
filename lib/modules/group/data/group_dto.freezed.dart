// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupDTO _$GroupDTOFromJson(Map<String, dynamic> json) {
  return _GroupDTO.fromJson(json);
}

/// @nodoc
mixin _$GroupDTO {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get local => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  int get weekDay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupDTOCopyWith<GroupDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupDTOCopyWith<$Res> {
  factory $GroupDTOCopyWith(GroupDTO value, $Res Function(GroupDTO) then) =
      _$GroupDTOCopyWithImpl<$Res, GroupDTO>;
  @useResult
  $Res call(
      {String id,
      String title,
      String local,
      String? image,
      String startTime,
      String endTime,
      int weekDay});
}

/// @nodoc
class _$GroupDTOCopyWithImpl<$Res, $Val extends GroupDTO>
    implements $GroupDTOCopyWith<$Res> {
  _$GroupDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? local = null,
    Object? image = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? weekDay = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      local: null == local
          ? _value.local
          : local // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      weekDay: null == weekDay
          ? _value.weekDay
          : weekDay // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupDTOCopyWith<$Res> implements $GroupDTOCopyWith<$Res> {
  factory _$$_GroupDTOCopyWith(
          _$_GroupDTO value, $Res Function(_$_GroupDTO) then) =
      __$$_GroupDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String local,
      String? image,
      String startTime,
      String endTime,
      int weekDay});
}

/// @nodoc
class __$$_GroupDTOCopyWithImpl<$Res>
    extends _$GroupDTOCopyWithImpl<$Res, _$_GroupDTO>
    implements _$$_GroupDTOCopyWith<$Res> {
  __$$_GroupDTOCopyWithImpl(
      _$_GroupDTO _value, $Res Function(_$_GroupDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? local = null,
    Object? image = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? weekDay = null,
  }) {
    return _then(_$_GroupDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      local: null == local
          ? _value.local
          : local // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      weekDay: null == weekDay
          ? _value.weekDay
          : weekDay // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupDTO implements _GroupDTO {
  const _$_GroupDTO(
      {required this.id,
      required this.title,
      required this.local,
      required this.image,
      required this.startTime,
      required this.endTime,
      required this.weekDay});

  factory _$_GroupDTO.fromJson(Map<String, dynamic> json) =>
      _$$_GroupDTOFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String local;
  @override
  final String? image;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final int weekDay;

  @override
  String toString() {
    return 'GroupDTO(id: $id, title: $title, local: $local, image: $image, startTime: $startTime, endTime: $endTime, weekDay: $weekDay)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.local, local) || other.local == local) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.weekDay, weekDay) || other.weekDay == weekDay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, local, image, startTime, endTime, weekDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupDTOCopyWith<_$_GroupDTO> get copyWith =>
      __$$_GroupDTOCopyWithImpl<_$_GroupDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupDTOToJson(
      this,
    );
  }
}

abstract class _GroupDTO implements GroupDTO {
  const factory _GroupDTO(
      {required final String id,
      required final String title,
      required final String local,
      required final String? image,
      required final String startTime,
      required final String endTime,
      required final int weekDay}) = _$_GroupDTO;

  factory _GroupDTO.fromJson(Map<String, dynamic> json) = _$_GroupDTO.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get local;
  @override
  String? get image;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  int get weekDay;
  @override
  @JsonKey(ignore: true)
  _$$_GroupDTOCopyWith<_$_GroupDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
