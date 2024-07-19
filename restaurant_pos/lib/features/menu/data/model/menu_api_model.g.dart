// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuApiModel _$MenuApiModelFromJson(Map<String, dynamic> json) => MenuApiModel(
      menuId: json['_id'] as String?,
      menuName: json['menuName'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
    );

Map<String, dynamic> _$MenuApiModelToJson(MenuApiModel instance) =>
    <String, dynamic>{
      '_id': instance.menuId,
      'menuName': instance.menuName,
      'image': instance.image,
      'price': instance.price,
    };
