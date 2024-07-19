import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/order/data/data_source/order_remote_data_source.dart';
import 'package:restaurant_pos/features/order/domain/entity/order_entity.dart';
import 'package:restaurant_pos/features/order/domain/repository/order_repository.dart';

final orderRemoteRepoProvider = Provider<IOrderRepository>(
  (ref) => OrderRemoteRepositoryImpl(
    orderRemoteDataSource: ref.read(orderRemoteDataSourceProvider),
  ),
);

class OrderRemoteRepositoryImpl implements IOrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;

  OrderRemoteRepositoryImpl({required this.orderRemoteDataSource});

  @override
  Future<Either<Failure, bool>> placeOrder(OrderEntity order) {
    return orderRemoteDataSource.placeOrder(order);
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getAllOrders() {
    return orderRemoteDataSource.getAllOrders();
  }

  @override
  Future<Either<Failure, bool>> deleteOrder(String id) {
    return orderRemoteDataSource.deleteOrder(id);
  }

  @override
  Future<Either<Failure, bool>> updateOrder(OrderEntity order, String id) {
    return orderRemoteDataSource.updateOrder(order, id);
  }
  
  @override
  Future<Either<Failure, bool>> updateOrderStatus(OrderEntity order, String id) {
    return orderRemoteDataSource.updateStatusToPaid(order, id);
  }
}
