import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';
import 'package:restaurant_pos/features/menu/presentation/viewmodel/menu_view_model.dart';
import 'package:restaurant_pos/features/menu/presentation/widget/load_menu.dart';

class AddMenuView extends ConsumerStatefulWidget {
  const AddMenuView({super.key});

  @override
  ConsumerState<AddMenuView> createState() => _AddMenuViewState();
}

class _AddMenuViewState extends ConsumerState<AddMenuView> {
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource1) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource1);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(menuViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final gap = const SizedBox(height: 8);
  TextEditingController menuController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var menuState = ref.watch(menuViewModelProvider);
    return SafeArea(
      child: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.grey[300],
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              checkCameraPermission();
                              _browseImage(ref, ImageSource.camera);
                              Navigator.pop(context);
                              // Upload image it is not null
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _browseImage(ref, ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.image),
                            label: const Text('Gallery'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _img != null
                        ? FileImage(_img!)
                        : const AssetImage('assets/images/default_image.jpg')
                            as ImageProvider,
                  ),
                ),
              ),
              gap,
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Add Menu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              gap,
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
              gap,
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
              gap,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      var menu = MenuEntity(
                        menuName: menuController.text,
                        image: ref.read(menuViewModelProvider).imageName ?? '',
                        price: double.parse(priceController.text),
                      );
                      ref
                          .read(menuViewModelProvider.notifier)
                          .addMenu(context, menu);
                           await ref.read(menuViewModelProvider.notifier).getAllMenus();
                    }
                  },
                  child: const Text('Add Menu'),
                ),
              ),
    
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'List of Menus',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (menuState.isLoading) ...{
                const Center(child: CircularProgressIndicator()),
              } else if (menuState.error != null) ...{
                Text(menuState.error.toString()),
              } else if (menuState.menus.isEmpty) ...{
                const Center(child: Text('No Menus')),
              } else ...{
                Expanded(
                  child: LoadMenu(
                    lstMenus: menuState.menus,
                    ref: ref,
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
