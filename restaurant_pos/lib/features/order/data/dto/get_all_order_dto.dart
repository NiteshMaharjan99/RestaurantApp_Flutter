import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_pos/features/order/data/model/order_api_model.dart';

part 'get_all_order_dto.g.dart';

@JsonSerializable()
class GetAllOrdersDTO {
  final bool success;
  final int count;
  final List<OrderApiModel> data;

  GetAllOrdersDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllOrdersDTOToJson(this);

  factory GetAllOrdersDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllOrdersDTOFromJson(json);
}
