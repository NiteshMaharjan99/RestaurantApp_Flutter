import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/menu/data/data_source/menu_local_data_source.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';
import 'package:restaurant_pos/features/menu/domain/repository/menu_repository.dart';

final menuLocalRepoProvider = Provider<IMenuRepository>((ref) {
  return MenuLocalRepositoryImpl(
    menuLocalDataSource: ref.read(menuLocalDataSourceProvider),
  );
});

class MenuLocalRepositoryImpl implements IMenuRepository {
  final MenuLocalDataSource menuLocalDataSource;

  MenuLocalRepositoryImpl({
    required this.menuLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> addMenu(MenuEntity menu) {
    return menuLocalDataSource.addMenu(menu);
  }

  @override
  Future<Either<Failure, List<MenuEntity>>> getAllMenus() {
    return menuLocalDataSource.getAllMenues();
  }

  @override
  Future<Either<Failure, bool>> deleteMenu(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadMenuImage(File file) {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, bool>> updateMenu(MenuEntity menu, String id) {
    throw UnimplementedError();
  }
}
