import 'package:flutter/material.dart';
import 'package:restaurant_pos/config/constants/api_endpoint.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';
import 'package:restaurant_pos/features/order/presentation/view/pos_order_view.dart';

class MenuWidget extends StatelessWidget {
  final List<MenuEntity> menuList;
  const MenuWidget({super.key, required this.menuList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: menuList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PosOrderView(
                    menu: menuList[index],
                    menuList: menuList,
                  );
                },
              ),
            );
          },
          child: Card(
            color: Colors.yellow[100],
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.14,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: menuList[index].image.isNotEmpty
                        ? Image.network(
                            ApiEndpoints.imageUrl + menuList[index].image,
                            // height: 100,
                            // width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Display placeholder image or alternative text
                              return Image.asset(
                                'assets/images/default_image.jpg',
                                // height: 100,
                                // width: 100,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/default_image.jpg',
                            // height: 100,
                            // width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                  // Handle Image only when connected to the network

                  const SizedBox(height: 8),
                  Text(
                    menuList[index].menuName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${menuList[index].price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
