import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:restaurant_pos/features/menu/presentation/view/add_menu_view.dart';
import 'package:restaurant_pos/features/order/presentation/view/order_view.dart';
import 'package:sensors/sensors.dart';

import 'bottom_screen/home_screen.dart';
import 'bottom_screen/profile_screen.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent  event) {
      double xAxisValue = event.x;
      if (xAxisValue  > 8.0) {
        setState(() {
         ref.read(homeViewModelProvider.notifier).logout(context);
        });
      } 
    });
  }


  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const AddMenuView(),
    const OrderView(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dining),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
