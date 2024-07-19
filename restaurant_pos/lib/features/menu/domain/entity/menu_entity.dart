import 'package:equatable/equatable.dart';

class MenuEntity extends Equatable{
  final String? menuId;
  final String menuName;
  final double price;
  final String image;

  const MenuEntity({
    this.menuId,
    required this.menuName,
    required this.price,
    required this.image
  });

  factory MenuEntity.fromJson(Map<String, dynamic> json) => MenuEntity(
        menuId: json["menuId"] as String?,
        menuName: json["menuName"] as String,
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "menuName": menuName,
        "image": image,
        "price": price,
      };

  @override
  List<Object?> get props => [menuId, menuName, price, image];
}
