import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_pos/config/constants/hive_table_constant.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';
import 'package:uuid/uuid.dart';

part 'menu_hive_model.g.dart';

final menuHiveModelProvider = Provider(
  (ref) => MenuHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.menuTableId)
class MenuHiveModel extends HiveObject {
  @HiveField(0)
  final String menuId;

  @HiveField(1)
  final String menuName;
  
  @HiveField(2)
  final double price;

  @HiveField(3)
  final String image;

  // empty constructor
  MenuHiveModel.empty() : this(menuId: '', menuName: '', price: 0, image: '');

  MenuHiveModel({
    String? menuId,
    required this.menuName,
    required this.price,
    required this.image,
  }) : menuId = menuId ?? const Uuid().v4();

  // Convert Hive Object to Entity
  MenuEntity toEntity() => MenuEntity(
        menuId: menuId,
        menuName: menuName,
        price: price,
        image: image,
      );

  // Convert Entity to Hive Object
  MenuHiveModel toHiveModel(MenuEntity entity) => MenuHiveModel(
        // batchId: entity.batchId,
        menuName: entity.menuName,
        price: entity.price,
        image: entity.image, 
      );

  // Convert Hive List to Entity List
  List<MenuEntity> toEntityList(List<MenuHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'menuId: $menuId, menuName: $menuName, price: $price, image: $image';
  }
}
