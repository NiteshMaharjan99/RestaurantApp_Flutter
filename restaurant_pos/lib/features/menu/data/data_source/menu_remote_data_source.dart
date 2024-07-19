import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/config/constants/api_endpoint.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/core/network/remote/http_service.dart';
import 'package:restaurant_pos/core/shared_prefs/user_shared_prefs.dart';
import 'package:restaurant_pos/features/menu/data/dto/get_all_menu_dto.dart';
import 'package:restaurant_pos/features/menu/data/model/menu_api_model.dart';
import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';

final menuRemoteDataSourceProvider = Provider(
  (ref) => MenuRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    menuApiModel: ref.read(menuApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    // authApiModel: ref.read(authApiModelProvider),
  ),
);

class MenuRemoteDataSource {
  final Dio dio;
  final MenuApiModel menuApiModel;
  // final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  MenuRemoteDataSource({
    required this.dio,
    required this.menuApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addMenu(MenuEntity menu) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.createMenu,
        data: menu.toJson()
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  // Upload image using multipart
 Future<Either<Failure, String>> uploadMenuImage(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );
      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0,'));
    }
  }

  Future<Either<Failure, List<MenuEntity>>> getAllMenus() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllMenus);
      if (response.statusCode == 200) {
        GetAllMenuDTO getAllMenuDTO = GetAllMenuDTO.fromJson(response.data);
        return Right(menuApiModel.toEntityList(getAllMenuDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteMenu(String menuId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteMenu + menuId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

   Future<Either<Failure, bool>> updateMenu(MenuEntity menu, String menuId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.put(
        ApiEndpoints.updateMenu + menuId,
        data: menu.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}
