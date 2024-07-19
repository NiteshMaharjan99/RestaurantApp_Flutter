import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_pos/features/order/domain/entity/order_entity.dart';

part 'order_api_model.g.dart';

final orderApiModelProvider = Provider<OrderApiModel>(
  (ref) => const OrderApiModel.empty(),
);

@JsonSerializable()
class OrderApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? orderId;
  final double totalAmount;
  final List<dynamic> menus;

  const OrderApiModel({
    this.orderId,
    required this.menus,
    required this.totalAmount,
  });

  const OrderApiModel.empty()
      : orderId = '',
        totalAmount = 0,
        menus = const [];

  Map<String, dynamic> toJson() => _$OrderApiModelToJson(this);

  factory OrderApiModel.fromJson(Map<String, dynamic> json) =>
      _$OrderApiModelFromJson(json);

  // Convert API Object to Entity
  OrderEntity toEntity() => OrderEntity(
        orderId: orderId,
        menus: menus,
        totalAmount: totalAmount,
      );

  // Convert Entity to API Object
  OrderApiModel fromEntity(OrderEntity entity) => OrderApiModel(
        orderId: entity.orderId ?? '',
        menus: entity.menus,
        totalAmount: entity.totalAmount,
      );

  // Convert API List to Entity List
  List<OrderEntity> toEntityList(List<OrderApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [orderId, menus, totalAmount];
}
