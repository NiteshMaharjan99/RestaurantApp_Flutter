import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/auth/domain/entity/student_entity.dart';
import 'package:restaurant_pos/features/auth/domain/repository/user_repository.dart';

final userUseCaseProvider = Provider((ref) {
  return UserUseCase(
    ref.read(userRepositoryProvider),
  );
});

class UserUseCase {
  final IUserRepository _userRepository;
  UserUseCase(this._userRepository);

  Future<Either<Failure, bool>> registerUser(StudentEntity user) async {
    return await _userRepository.registerUser(user);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await _userRepository.uploadProfilePicture(file);
  }

  Future<Either<Failure, bool>> loginUser(
      String username, String password) async {
    return await _userRepository.loginUser(username, password);
  }

  Future<Either<Failure, StudentEntity?>> getUserData() async {
    return await _userRepository.getUserData();
  }
}
