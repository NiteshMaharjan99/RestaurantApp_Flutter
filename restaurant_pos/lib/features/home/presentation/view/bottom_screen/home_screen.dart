import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/common/snackbar/my_snackbar.dart';
import 'package:restaurant_pos/features/home/presentation/widget/dashboard_image_banner.dart';
import 'package:restaurant_pos/features/home/presentation/widget/menu_widget.dart';
import 'package:restaurant_pos/features/menu/presentation/viewmodel/menu_view_model.dart';
import 'package:restaurant_pos/features/order/presentation/viewmodel/order_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var menuState = ref.watch(menuViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const DashboardBannerImage(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menus',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: MenuWidget(menuList: menuState.menus),
            ),
          ],
        ),
      ),
      // body: InternetCheck(),
    );
  }
}
