import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/order/domain/entity/order_entity.dart';
import 'package:restaurant_pos/features/order/domain/repository/order_repository.dart';

final orderUsecaseProvider = Provider<OrderUseCase>(
  (ref) => OrderUseCase(
    orderRepository: ref.watch(orderRepositoryProvider),
  ),
);

class OrderUseCase {
  final IOrderRepository orderRepository;

  OrderUseCase({required this.orderRepository});

  Future<Either<Failure, List<OrderEntity>>> getAllOrders() {
    return orderRepository.getAllOrders();
  }

  Future<Either<Failure, bool>> placeOrder(OrderEntity order) {
    return orderRepository.placeOrder(order);
  }

  Future<Either<Failure, bool>> deleteOrder(String id) async {
    return orderRepository.deleteOrder(id);
  }

  Future<Either<Failure, bool>> updateOrder(
      OrderEntity order, String id) async {
    return await orderRepository.updateOrder(order, id);
  }

  Future<Either<Failure, bool>> updateStatusToPaid(
      OrderEntity order, String id) async {
    return await orderRepository.updateOrderStatus(order, id);
  }
}
