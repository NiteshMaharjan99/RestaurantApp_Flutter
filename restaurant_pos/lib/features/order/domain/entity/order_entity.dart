import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? orderId;
  final List<dynamic> menus;
  final double totalAmount;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OrderEntity(
      {this.orderId,
      required this.menus,
      required this.totalAmount,
      this.status,
      this.createdAt,
      this.updatedAt});

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    List<dynamic> menuItems = json["menus"];

    return OrderEntity(
      orderId: json["orderId"] as String?,
      menus: menuItems,
      totalAmount: json["totalAmount"],
      status: json["status"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "menus": menus,
        "totalAmount": totalAmount,
        "status": status,
        "createdAt": createdAt,
        "updatedAt": updatedAt
      };

  @override
  List<Object?> get props =>
      [orderId, menus, totalAmount, status, createdAt, updatedAt];
}
