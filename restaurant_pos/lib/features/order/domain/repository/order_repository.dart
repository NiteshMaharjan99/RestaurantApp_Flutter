import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/order/data/repository/order_remote_repo_impl.dart';
import 'package:restaurant_pos/features/order/domain/entity/order_entity.dart';

final orderRepositoryProvider = Provider<IOrderRepository>((ref) {
  return ref.watch(orderRemoteRepoProvider);
});

abstract class IOrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getAllOrders();
  Future<Either<Failure, bool>> placeOrder(OrderEntity order);
  Future<Either<Failure, bool>> deleteOrder(String id);
  Future<Either<Failure, bool>> updateOrder(OrderEntity order, String id);
  Future<Either<Failure, bool>> updateOrderStatus(OrderEntity order, String id);
}
