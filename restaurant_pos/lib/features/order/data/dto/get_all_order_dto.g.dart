// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllOrdersDTO _$GetAllOrdersDTOFromJson(Map<String, dynamic> json) =>
    GetAllOrdersDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => OrderApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllOrdersDTOToJson(GetAllOrdersDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
