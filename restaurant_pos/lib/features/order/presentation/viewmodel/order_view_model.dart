import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/common/snackbar/my_snackbar.dart';
import 'package:restaurant_pos/features/order/domain/entity/order_entity.dart';
import 'package:restaurant_pos/features/order/domain/use_case/order_use_case.dart';
import 'package:restaurant_pos/features/order/presentation/state/order_state.dart';

final orderViewModelProvider =
    StateNotifierProvider<OrderViewModel, OrderState>(
  (ref) => OrderViewModel(ref.watch(orderUsecaseProvider)),
);

class OrderViewModel extends StateNotifier<OrderState> {
  final OrderUseCase orderUseCase;

  OrderViewModel(this.orderUseCase) : super(OrderState.initial()) {
    getAllOrders();
  }

  Future<void> placeOrder(BuildContext context, OrderEntity order) async {
    state.copyWith(isLoading: true);
    var data = await orderUseCase.placeOrder(order);

    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: "Order Placed Successfully", context: context);
      },
    );
  }

  getAllOrders() async {
    state = state.copyWith(isLoading: true);
    var data = await orderUseCase.getAllOrders();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, orders: r, error: null),
    );
  }

  Future<void> deleteOrder(BuildContext context, OrderEntity order) async {
    state.copyWith(isLoading: true);
    var data = await orderUseCase.deleteOrder(order.orderId!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.orders.remove(order);
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Order deleted successfully',
          context: context,
        );
      },
    );
  }

  Future<void> updateOrder(BuildContext context, OrderEntity order) async {
    state = state.copyWith(isLoading: true);
    var data = await orderUseCase.updateOrder(order, order.orderId!);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: "Order updated successfully", context: context);
      },
    );
  }

  Future<void> updateStatusToPaid(BuildContext context, OrderEntity order) async {
    state = state.copyWith(isLoading: true);
    var data = await orderUseCase.updateOrder(order, order.orderId!);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: "Order updated successfully", context: context);
      },
    );
  }

 
}
