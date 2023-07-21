// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupDTO _$$_GroupDTOFromJson(Map<String, dynamic> json) => _$_GroupDTO(
      id: json['id'] as String,
      title: json['title'] as String,
      local: json['local'] as String,
      image: json['image'] as String?,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      weekDay: json['weekDay'] as int,
    );

Map<String, dynamic> _$$_GroupDTOToJson(_$_GroupDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'local': instance.local,
      'image': instance.image,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'weekDay': instance.weekDay,
    };
