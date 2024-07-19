import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/config/constants/api_endpoint.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';
import 'package:restaurant_pos/features/order/domain/entity/order_entity.dart';
import 'package:restaurant_pos/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:restaurant_pos/features/order/presentation/viewmodel/pos_order_controller.dart';

class PosOrderView extends StatefulWidget {
  final MenuEntity menu;
  final List<MenuEntity> menuList;
  const PosOrderView({Key? key, required this.menu, required this.menuList})
      : super(key: key);

  Widget build(context, PosOrderController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PosOrder"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[500],
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: null,
                      decoration: InputDecoration(
                        filled: false,
                        fillColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hintText: "What are you craving?",
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                        hoverColor: Colors.transparent,
                        focusedBorder:
                            InputBorder.none, // Remove focused border
                        enabledBorder: InputBorder.none,
                      ),
                      onFieldSubmitted: (value) =>
                          controller.updateSearch(value),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuList.length,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  Map<String, dynamic> item = menuList[index].toJson();

                  item["id"] = menuList[index].menuId;

                  if (controller.search.isNotEmpty) {
                    var search = controller.search.toLowerCase();
                    var productName = menuList[index].menuName.toLowerCase();
                    if (!productName.contains(search)) return Container();
                  }

                  if (item["menuName"] == menu.menuName) {
                    controller.addProductIfNotFound(item);
                  }

                  //item_cart
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        backgroundImage:
                            NetworkImage(ApiEndpoints.imageUrl + item["image"]),
                      ),
                      title: Text(item["menuName"]),
                      subtitle: Text("${item["price"]}"),
                      trailing: SizedBox(
                        width: 120.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 12.0,
                              child: Center(
                                child: IconButton(
                                  onPressed: () => controller.decreaseQty(item),
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 9.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${controller.getQty(item)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 12.0,
                              child: Center(
                                child: IconButton(
                                  onPressed: () => controller.increaseQty(item),
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 9.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.orange.shade200,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  controller.total.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Consumer(builder: (context, ref, child) {
            return Container(
              height: 72,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () async {
                  controller.products;
                  var order = OrderEntity(
                    menus: controller.products,
                    totalAmount: controller.total,
                  );
                  ref.read(orderViewModelProvider.notifier).placeOrder(context, order);
                },
                child: const Text("Checkout"),
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  State<PosOrderView> createState() => PosOrderController();
}
