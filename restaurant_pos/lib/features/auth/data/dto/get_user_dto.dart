import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_pos/features/auth/domain/entity/student_entity.dart';

part 'get_user_dto.g.dart';

@JsonSerializable()
class GetUserDTO {
  final bool? success;
  final String? message;
  final StudentEntity? data;

  GetUserDTO({
    required this.success,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetUserDTOToJson(this);

  factory GetUserDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserDTOFromJson(json);
}


