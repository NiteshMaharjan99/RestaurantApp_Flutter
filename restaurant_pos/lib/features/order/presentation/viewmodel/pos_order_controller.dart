import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_pos/features/order/presentation/view/pos_order_view.dart';

import '../state/state_util.dart';

class PosOrderController extends State<PosOrderView> implements MvcController {
  static late PosOrderController instance;
  late PosOrderView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String search = "";
  updateSearch(String query) {
    search = query;
    setState(() {});
  }

  List productList = [];

  getQty(item) {
    var index = productList.indexWhere((i) => i["id"] == item["id"]);
    if (index > -1) {
      productList[index]["quantity"] ??= 0;
      return productList[index]["quantity"];
    }
    return 0;
  }

  increaseQty(item) {
    addProductIfNotFound(item);

    var index = productList.indexWhere((i) => i["id"] == item["id"]);
    if (index > -1) {
      productList[index]["quantity"] ??= 0;
      productList[index]["quantity"]++;
    }
    setState(() {});
  }

  decreaseQty(item) {
    addProductIfNotFound(item);

    var index = productList.indexWhere((i) => i["menuId"] == item["menuId"]);
    if (index > -1) {
      productList[index]["quantity"] ??= 0;
      if (productList[index]["quantity"] == 0) return;
      productList[index]["quantity"]--;
    }
    setState(() {});
  }

  addProductIfNotFound(item) {
    var index = productList.indexWhere((i) => i["id"] == item["id"]);
    if (index == -1) {
      item["quantity"] = 0;
      productList.add(jsonDecode(jsonEncode(item)));
    }
  }

  double get total {
    double itemTotal = 0;
    for (var item in productList) {
      itemTotal += item["quantity"] * item["price"];
    }
    return itemTotal;
  }

  List get products {
    return productList;
  }

 
}
