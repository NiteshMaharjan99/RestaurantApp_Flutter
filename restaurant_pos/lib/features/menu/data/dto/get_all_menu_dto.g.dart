// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_menu_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllMenuDTO _$GetAllMenuDTOFromJson(Map<String, dynamic> json) =>
    GetAllMenuDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => MenuApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllMenuDTOToJson(GetAllMenuDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
