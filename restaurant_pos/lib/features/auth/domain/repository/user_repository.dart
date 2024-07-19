import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/auth/data/repository/user_remote_repository_impl.dart';
import 'package:restaurant_pos/features/auth/domain/entity/student_entity.dart';

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return ref.read(userRemoteRepositoryProvider);
});

abstract class IUserRepository {
  Future<Either<Failure, bool>> registerUser(StudentEntity user);
  Future<Either<Failure, bool>> loginUser(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, StudentEntity?>> getUserData();
}
