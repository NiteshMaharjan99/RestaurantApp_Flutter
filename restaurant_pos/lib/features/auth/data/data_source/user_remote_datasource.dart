import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/config/constants/api_endpoint.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/core/network/remote/http_service.dart';
import 'package:restaurant_pos/core/shared_prefs/user_shared_prefs.dart';
import 'package:restaurant_pos/features/auth/data/dto/get_user_dto.dart';
import 'package:restaurant_pos/features/auth/data/model/user_api_model.dart';
import 'package:restaurant_pos/features/auth/domain/entity/student_entity.dart';

final userRemoteDataSourceProvider = Provider(
  (ref) => UserRemoteDataSource(
      dio: ref.watch(httpServiceProvider),
      userSharedPrefs: ref.watch(userSharedPrefsProvider),
      authApiModel: ref.read(authApiModelProvider)),
);

class UserRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final AuthApiModel authApiModel;

  UserRemoteDataSource(
      {required this.dio,
      required this.userSharedPrefs,
      required this.authApiModel});

  // Register
  Future<Either<Failure, bool>> registerUser(StudentEntity user) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "fname": user.fname,
          "lname": user.lname,
          "image": user.image,
          "phone": user.phone,
          "username": user.username,
          "password": user.password,
        },
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //   },
        // ),
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

  // Upload image using multipart
  Future<Either<Failure, String>> uploadProfilePicture(
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

  // Login
  Future<Either<Failure, bool>> loginUser(
      String username, String password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "username": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // retrieve token
        String token = response.data["token"];
        await userSharedPrefs.setUserToken(token);
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

  Future<Either<Failure, StudentEntity?>> getUserDetails() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(
        ApiEndpoints.getUserDetails,
        options: Options(
          headers: {
            // "Authorization": Constant.token,
            "Authorization": 'Bearer $token',
          },
        ),
      );

      StudentEntity? user;
      if (response.statusCode == 200) {
        GetUserDTO userResponse = GetUserDTO.fromJson(response.data);
        user = userResponse.data;
        return Right(user);
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
}
