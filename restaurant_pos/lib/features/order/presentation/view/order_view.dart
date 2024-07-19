import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/common/snackbar/my_snackbar.dart';
import 'package:restaurant_pos/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:restaurant_pos/features/order/presentation/widget/order_widget.dart';

class OrderView extends ConsumerStatefulWidget {
  const OrderView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderViewState();
}

class _OrderViewState extends ConsumerState<OrderView> {

  @override
  Widget build(BuildContext context) {
    var orderState = ref.watch(orderViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order"),
        actions:  [
          IconButton(
            onPressed: () {
              ref.read(orderViewModelProvider.notifier).getAllOrders();
              showSnackBar(message: 'Refressing...', context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: OrderWidget(orderList: orderState.orders),
    );
  }
}