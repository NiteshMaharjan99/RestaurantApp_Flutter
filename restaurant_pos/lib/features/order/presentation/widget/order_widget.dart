import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_pos/core/widget/category_picker.dart';
import 'package:restaurant_pos/features/order/domain/entity/order_entity.dart';
import 'package:restaurant_pos/features/order/presentation/viewmodel/order_controller.dart';
import 'package:restaurant_pos/features/order/presentation/viewmodel/order_view_model.dart';

class OrderWidget extends StatefulWidget {
  final List<OrderEntity> orderList;
  const OrderWidget({Key? key, required this.orderList}) : super(key: key);

  Widget build(context, OrderController controller) {
    controller.view = this;

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          QCategoryPicker(
            items: const [
              {
                "label": "Pending",
                "value": "pending",
              },
              {
                "label": "Paid",
                "value": "paid",
              },
            ],
            value: "pending",
            onChanged: (index, label, value, item) {
              controller.updateStatus(value);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orderList.length,
              padding: EdgeInsets.zero,
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = orderList[index].toJson();

                item["id"] = orderList[index].orderId;
                final createdAt = item["createdAt"]
                    as DateTime; // Assuming createdAt is a string

                final formattedDate = DateFormat('dd MMM').format(createdAt);

                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  formattedDate.padLeft(2, "0"),
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Text(
                                //   month as String,
                                //   style: const TextStyle(
                                //     fontSize: 16.0,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "Item(s): ${item["menus"].length}",
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "Status: ${item["status"]}",
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              "${item["totalAmount"]}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Consumer(
                          builder: (context, ref, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                  ),
                                  // onPressed: () => {},
                                  onPressed: () => {
                                    ref
                                        .read(orderViewModelProvider.notifier)
                                        .updateStatusToPaid(context, orderList[index]),
                                  },
                                  child: const Text("Set Status to Paid"),
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<OrderWidget> createState() => OrderController();
}
