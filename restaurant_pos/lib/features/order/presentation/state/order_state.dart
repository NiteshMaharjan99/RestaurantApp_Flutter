import 'package:restaurant_pos/features/order/domain/entity/order_entity.dart';

class OrderState {
  final bool isLoading;
  final List<OrderEntity> orders;
  final String? error;

  OrderState({
    required this.isLoading,
    required this.orders,
    this.error,
  });

  factory OrderState.initial() {
    return OrderState(
      isLoading: false,
      orders: [],
    );
  }

  OrderState copyWith({
    bool? isLoading,
    List<OrderEntity>? orders,
    String? error,
    String? imageName,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'OrderState(isLoading: $isLoading, error: $error)';
}
