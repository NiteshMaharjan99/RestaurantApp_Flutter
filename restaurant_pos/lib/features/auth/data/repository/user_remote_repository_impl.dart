import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/auth/data/data_source/user_remote_datasource.dart';
import 'package:restaurant_pos/features/auth/domain/entity/student_entity.dart';
import 'package:restaurant_pos/features/auth/domain/repository/user_repository.dart';

final userRemoteRepositoryProvider = Provider<IUserRepository>((ref) {
  return UserRemoteRepositoryImpl(
    ref.read(userRemoteDataSourceProvider),
  );
});

class UserRemoteRepositoryImpl implements IUserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRemoteRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String username, String password) {
    return _userRemoteDataSource.loginUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(StudentEntity user) {
    return _userRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return _userRemoteDataSource.uploadProfilePicture(file);
  }
  
  @override
  Future<Either<Failure, StudentEntity?>> getUserData() {
    return _userRemoteDataSource.getUserDetails();
  }
}
