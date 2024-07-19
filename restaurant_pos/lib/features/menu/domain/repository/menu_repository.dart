import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/common/provider/internet_connectivity.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/menu/data/repository/menu_local_repo_impl.dart';
import 'package:restaurant_pos/features/menu/data/repository/menu_remote_repo_impl.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';

final menuRepositoryProvider = Provider<IMenuRepository>((ref) {
  // Check for internet connectivity status
  final internetStatus = ref.watch(connectivityStatusProvider);

  if (ConnectivityStatus.isConnected == internetStatus) {
    // If internet is available then return remote repo
    return ref.watch(menuRemoteRepoProvider);
  } else {
    // If internet is not available then return local repo
    return ref.watch(menuLocalRepoProvider);
  }
});

abstract class IMenuRepository {
  Future<Either<Failure, List<MenuEntity>>> getAllMenus();
  Future<Either<Failure, bool>> addMenu(MenuEntity menu);
  Future<Either<Failure, bool>> deleteMenu(String id);
  Future<Either<Failure, String>> uploadMenuImage(File file);
  Future<Either<Failure, bool>> updateMenu(MenuEntity menu, String id);
}
