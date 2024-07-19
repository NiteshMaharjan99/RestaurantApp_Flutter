
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';
import 'package:restaurant_pos/features/menu/presentation/viewmodel/menu_view_model.dart';

class EditMenuView extends ConsumerStatefulWidget {
  final MenuEntity menu;
  const EditMenuView({super.key, required this.menu});

  @override
  ConsumerState<EditMenuView> createState() => _EditMenuViewState();
}

class _EditMenuViewState extends ConsumerState<EditMenuView> {
  TextEditingController menuController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    menuController.text = widget.menu.menuName;
    priceController.text = widget.menu.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: menuController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Menu Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter menu';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Price',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the price';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
  onPressed: () async {
    if (menuController.text.isNotEmpty && priceController.text.isNotEmpty) {
      double price = double.tryParse(priceController.text) ?? 0.0;
      MenuEntity updatedMenu = MenuEntity(
        menuId: widget.menu.menuId,
        menuName: menuController.text,
        price: price,
        image: widget.menu.image,
      );
      await ref
          .read(menuViewModelProvider.notifier)
          .updateMenu(context, updatedMenu);
          await ref.read(menuViewModelProvider.notifier).getAllMenus();
      Navigator.pop(context);
    }
  },
  child: const Text('Update Menu'),
),
          ],
        ),
      ),
    );
  }
}
