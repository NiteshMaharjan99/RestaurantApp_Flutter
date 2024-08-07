import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/config/routes/app_route.dart';
import 'package:restaurant_pos/core/common/snackbar/my_snackbar.dart';
import 'package:restaurant_pos/core/shared_prefs/user_shared_prefs.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, bool>(
  (ref) => HomeViewModel(
    ref.read(userSharedPrefsProvider),
  ),
);

class HomeViewModel extends StateNotifier<bool> {
  final UserSharedPrefs _userSharedPrefs;
  HomeViewModel(this._userSharedPrefs) : super(false);

  void logout(BuildContext context) async {
    state = true;
    showSnackBar(
        message: 'Logging out....', context: context, color: Colors.red);

    await _userSharedPrefs.deleteUserToken();
    Future.delayed(const Duration(milliseconds: 2000), () {
      state = false;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.loginViewRoute,
        (route) => false,
      );
    });
  }
}
