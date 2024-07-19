import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/core/network/local/hive_service.dart';
import 'package:restaurant_pos/features/menu/data/model/menu_hive_model.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';

// Dependency Injection using Riverpod
final menuLocalDataSourceProvider = Provider<MenuLocalDataSource>((ref) {
  return MenuLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      menuHiveModel: ref.read(menuHiveModelProvider));
});

class MenuLocalDataSource {
  final HiveService hiveService;
  final MenuHiveModel menuHiveModel;

  MenuLocalDataSource({
    required this.hiveService,
    required this.menuHiveModel,
  });


  Future<Either<Failure, bool>> addMenu(MenuEntity menu) async {
    try {
      // Convert Entity to Hive Object
      final hiveMenu = menuHiveModel.toHiveModel(menu);
      // Add to Hive
      await hiveService.addMenu(hiveMenu);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<MenuEntity>>> getAllMenues() async {
    try {

      final menues = await hiveService.getAllMenus();
      // Convert Hive Object to Entity
      final menuEntities = menuHiveModel.toEntityList(menues);
      return Right(menuEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
