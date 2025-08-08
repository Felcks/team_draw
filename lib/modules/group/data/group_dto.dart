import 'package:freezed_annotation/freezed_annotation.dart';


part 'group_dto.freezed.dart';
part 'group_dto.g.dart';

@freezed
class GroupDTO with  _$GroupDTO {

  const factory GroupDTO({
    required String id,
    required String userId,
    required String title,
    required String local,
    required String? image,
    required String startTime,
    required String endTime,
    required int weekDay,
  }) = _GroupDTO;

  factory GroupDTO.fromJson(Map<String, Object?> json)
    => _$GroupDTOFromJson(json);
}