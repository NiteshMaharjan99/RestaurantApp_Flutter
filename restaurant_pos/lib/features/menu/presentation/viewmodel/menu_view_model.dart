import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/common/snackbar/my_snackbar.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';
import 'package:restaurant_pos/features/menu/domain/use_case/menu_use_case.dart';
import 'package:restaurant_pos/features/menu/presentation/state/menu_state.dart';

final menuViewModelProvider = StateNotifierProvider<MenuViewModel, MenuState>(
  (ref) => MenuViewModel(ref.watch(menuUsecaseProvider)),
);

class MenuViewModel extends StateNotifier<MenuState> {
  final MenuUseCase menuUseCase;

  MenuViewModel(this.menuUseCase) : super(MenuState.initial()) {
    getAllMenus();
  }

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await menuUseCase.uploadMenuImage(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  Future<void> addMenu(BuildContext context, MenuEntity menu) async {
    state.copyWith(isLoading: true);
    var data = await menuUseCase.addMenu(menu);

    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: "Added Successfully", context: context);
      },
    );
  }

  getAllMenus() async {
    state = state.copyWith(isLoading: true);
    var data = await menuUseCase.getAllMenus();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, menus: r, error: null),
    );
  }

  Future<void> deleteMenu(BuildContext context, MenuEntity menu) async {
    state.copyWith(isLoading: true);
    var data = await menuUseCase.deleteMenu(menu.menuId!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.menus.remove(menu);
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Menu deleted successfully',
          context: context,
        );
      },
    );
  }

  Future<void> updateMenu(BuildContext context, MenuEntity menu) async {
    state = state.copyWith(isLoading: true);
    var data = await menuUseCase.updateMenu(menu, menu.menuId!);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: "Menu updated successfully", context: context);
      },
    );
  }

  
}
