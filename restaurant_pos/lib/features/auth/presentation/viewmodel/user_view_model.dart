import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/config/routes/app_route.dart';
import 'package:restaurant_pos/core/common/snackbar/my_snackbar.dart';
import 'package:restaurant_pos/features/auth/domain/entity/student_entity.dart';
import 'package:restaurant_pos/features/auth/domain/use_case/user_use_case.dart';
import 'package:restaurant_pos/features/auth/presentation/state/user_state.dart';

final userViewModelProvider = StateNotifierProvider<UserViewModel, UserState>(
  (ref) {
    return UserViewModel(
      ref.read(userUseCaseProvider),
    );
  },
);

class UserViewModel extends StateNotifier<UserState> {
  final UserUseCase _userUseCase;

  UserViewModel(this._userUseCase) : super(UserState(isLoading: false));

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _userUseCase.uploadProfilePicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  Future<void> registerUser( StudentEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await _userUseCase.registerUser(user);
    data.fold(
      (failure) => {
        state = state.copyWith(isLoading: false, error: failure.error),
        // showSnackBar(
        //     message: 'Invalid credentials', context: context, color: Colors.red)
      },
      (success) => {
        state = state.copyWith(isLoading: false, error: null),
        // showSnackBar(message: "Successfully registered", context: context),
      },
    );
  }

  Future<bool> loginUser(
      BuildContext context, String username, String password) async {
    state = state.copyWith(isLoading: true);
    bool isLogin = false;
    var data = await _userUseCase.loginUser(username, password);
    data.fold(
      (failure) => {
        state = state.copyWith(isLoading: false, error: failure.error),
        showSnackBar(
          message: 'Invalid credentials',
          context: context,
          color: Colors.red,
        )
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        Navigator.popAndPushNamed(context, AppRoute.dashboardViewRoute);
      },
    );

    return isLogin;
  }

  
}
