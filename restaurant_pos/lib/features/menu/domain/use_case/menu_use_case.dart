import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';
import 'package:restaurant_pos/features/menu/domain/repository/menu_repository.dart';

final menuUsecaseProvider = Provider<MenuUseCase>(
  (ref) => MenuUseCase(
    menuRepository: ref.watch(menuRepositoryProvider),
  ),
);

class MenuUseCase {
  final IMenuRepository menuRepository;

  MenuUseCase({required this.menuRepository});

  Future<Either<Failure, String>> uploadMenuImage(File file) async {
    return await menuRepository.uploadMenuImage(file);
  }

  Future<Either<Failure, List<MenuEntity>>> getAllMenus() {
    return menuRepository.getAllMenus();
  }

  Future<Either<Failure, bool>> addMenu(MenuEntity menu) {
    return menuRepository.addMenu(menu);
  }

  Future<Either<Failure, bool>> deleteMenu(String id) async {
    return menuRepository.deleteMenu(id);
  }

  Future<Either<Failure, bool>> updateMenu(MenuEntity menu, String id) async {
    return await menuRepository.updateMenu(menu, id);
  }
}
