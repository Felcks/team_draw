// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MatchPlayerDTO _$$_MatchPlayerDTOFromJson(Map<String, dynamic> json) =>
    _$_MatchPlayerDTO(
      matchId: json['matchId'] as String,
      playerId: json['playerId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$_MatchPlayerDTOToJson(_$_MatchPlayerDTO instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'playerId': instance.playerId,
      'status': instance.status,
    };
