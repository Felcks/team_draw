// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayerDTO _$$_PlayerDTOFromJson(Map<String, dynamic> json) => _$_PlayerDTO(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      name: json['name'] as String,
      overall: json['overall'] as int,
    );

Map<String, dynamic> _$$_PlayerDTOToJson(_$_PlayerDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'name': instance.name,
      'overall': instance.overall,
    };
