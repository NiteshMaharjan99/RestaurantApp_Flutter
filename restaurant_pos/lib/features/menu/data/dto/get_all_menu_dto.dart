import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_pos/features/menu/data/model/menu_api_model.dart';

part 'get_all_menu_dto.g.dart';

@JsonSerializable()
class GetAllMenuDTO {
  final bool success;
  final int count;
  final List<MenuApiModel> data;

  GetAllMenuDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllMenuDTOToJson(this);

  factory GetAllMenuDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllMenuDTOFromJson(json);
}


