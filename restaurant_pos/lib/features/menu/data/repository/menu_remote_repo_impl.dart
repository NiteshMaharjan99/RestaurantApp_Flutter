import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/menu/data/data_source/menu_remote_data_source.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';
import 'package:restaurant_pos/features/menu/domain/repository/menu_repository.dart';

final menuRemoteRepoProvider = Provider<IMenuRepository>(
  (ref) => MenuRemoteRepositoryImpl(
    menuRemoteDataSource: ref.read(menuRemoteDataSourceProvider),
  ),
);

class MenuRemoteRepositoryImpl implements IMenuRepository {
  final MenuRemoteDataSource menuRemoteDataSource;

  MenuRemoteRepositoryImpl({required this.menuRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addMenu(MenuEntity menu) {
    return menuRemoteDataSource.addMenu(menu);
  }

  @override
  Future<Either<Failure, List<MenuEntity>>> getAllMenus() {
    return menuRemoteDataSource.getAllMenus();
  }

   @override
  Future<Either<Failure, bool>> deleteMenu(String id) {
    return menuRemoteDataSource.deleteMenu(id);
  }

  @override
  Future<Either<Failure, String>> uploadMenuImage(File file) {
    return menuRemoteDataSource.uploadMenuImage(file);
  }
  
  @override
  Future<Either<Failure, bool>> updateMenu(MenuEntity menu, String id) {
    return menuRemoteDataSource.updateMenu(menu, id);
  }
  
}
