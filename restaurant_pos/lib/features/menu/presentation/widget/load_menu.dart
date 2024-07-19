import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/config/constants/api_endpoint.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';
import 'package:restaurant_pos/features/menu/presentation/view/edit_menu_view.dart';
import 'package:restaurant_pos/features/menu/presentation/viewmodel/menu_view_model.dart';

class LoadMenu extends StatelessWidget {
  final WidgetRef ref;
  final List<MenuEntity> lstMenus;
  const LoadMenu({super.key, required this.lstMenus, required this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lstMenus.length,
      itemBuilder: ((context, index) => ListTile(
            leading: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.1,
                child: Image.network(
                    ApiEndpoints.imageUrl + lstMenus[index].image,
                    fit: BoxFit.cover,)),
            title: Text(lstMenus[index].menuName),
            subtitle: Text(lstMenus[index].price.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                            'Are you sure you want to delete ${lstMenus[index].menuName}?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ref
                                  .read(menuViewModelProvider.notifier)
                                  .deleteMenu(context, lstMenus[index]);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditMenuView(menu: lstMenus[index]),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          )),
    );
  }
}
