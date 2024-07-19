import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/config/constants/api_endpoint.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/core/network/remote/http_service.dart';
import 'package:restaurant_pos/core/shared_prefs/user_shared_prefs.dart';
import 'package:restaurant_pos/features/order/data/dto/get_all_order_dto.dart';
import 'package:restaurant_pos/features/order/data/model/order_api_model.dart';
import 'package:restaurant_pos/features/order/domain/entity/order_entity.dart';

final orderRemoteDataSourceProvider = Provider(
  (ref) => OrderRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    orderApiModel: ref.read(orderApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class OrderRemoteDataSource {
  final Dio dio;
  final OrderApiModel orderApiModel;
  final UserSharedPrefs userSharedPrefs;

  OrderRemoteDataSource({
    required this.dio,
    required this.orderApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> placeOrder(OrderEntity order) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.createOrder,
        data: order.toJson(),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<OrderEntity>>> getAllOrders() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllOrders);
       if (response.statusCode == 200) {
        List<dynamic> responseData = response.data as List<dynamic>;

        List<OrderEntity> orders = responseData.map((orderData) {
          return OrderEntity.fromJson(orderData);
        }).toList();

        return Right(orders);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteOrder(String orderId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteOrder + orderId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> updateOrder(
      OrderEntity order, String orderId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.put(
        ApiEndpoints.updateOrder + orderId,
        data: order.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> updateStatusToPaid(
      OrderEntity order, String orderId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.put(
        ApiEndpoints.updateOrderStatus + orderId,
        data: {'status': 'paid'},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}
