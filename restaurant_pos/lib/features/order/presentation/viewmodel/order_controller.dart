import 'package:flutter/material.dart';
import 'package:restaurant_pos/features/order/presentation/state/state_util.dart';
import 'package:restaurant_pos/features/order/presentation/widget/order_widget.dart';

class OrderController extends State<OrderWidget> implements MvcController {
  static late OrderController instance;
  late OrderWidget view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  // updateStatusToPaid({
  //   required String orderId,
  //   required String tableNumber,
  // }) async {
  //   await OrderService().setOrderToPaid(
  //     orderId: orderId,
  //     tableNumber: tableNumber,
  //   );
  // }

  String status = "pending";
  updateStatus(newStatus) {
    status = newStatus;
    setState(() {});
  }
}
