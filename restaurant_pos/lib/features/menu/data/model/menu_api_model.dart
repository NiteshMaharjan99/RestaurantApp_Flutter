import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';

part 'menu_api_model.g.dart';

final menuApiModelProvider = Provider<MenuApiModel>(
  (ref) => const MenuApiModel.empty(),
);

@JsonSerializable()
class MenuApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? menuId;
  final String menuName;
  final String image;
  final double price;

  const MenuApiModel({
     this.menuId,
    required this.menuName,
    required this.price,
    required this.image,
  });
  const MenuApiModel.empty()
      : menuId = '',
        menuName = '',
        image = '',
        price = 0;

  Map<String, dynamic> toJson() => _$MenuApiModelToJson(this);

  factory MenuApiModel.fromJson(Map<String, dynamic> json) =>
      _$MenuApiModelFromJson(json);

  // Convert API Object to Entity
  MenuEntity toEntity() => MenuEntity(
        menuId: menuId,
        menuName: menuName,
        price: price,
        image: image,
      );

  // Convert Entity to API Object
  MenuApiModel fromEntity(MenuEntity entity) => MenuApiModel(
        menuId: entity.menuId ?? '',
        menuName: entity.menuName,
        price:  entity.price,
        image: entity.image,
      );

  // Convert API List to Entity List
  List<MenuEntity> toEntityList(List<MenuApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

   @override
  List<Object?> get props => [menuId, menuName, price, image];
  
}
