// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderApiModel _$OrderApiModelFromJson(Map<String, dynamic> json) =>
    OrderApiModel(
      orderId: json['_id'] as String?,
      menus: json['menus'] as List<dynamic>,
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderApiModelToJson(OrderApiModel instance) =>
    <String, dynamic>{
      '_id': instance.orderId,
      'totalAmount': instance.totalAmount,
      'menus': instance.menus,
    };
