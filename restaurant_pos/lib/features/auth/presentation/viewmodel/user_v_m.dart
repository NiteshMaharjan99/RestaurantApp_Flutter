import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_pos/features/auth/domain/use_case/user_use_case.dart';
import 'package:restaurant_pos/features/auth/presentation/state/new_state.dart';

final userVMProvider = StateNotifierProvider<UserVM, NewState>(
  (ref) {
    return UserVM(
      ref.read(userUseCaseProvider),
    );
  },
);

class UserVM extends StateNotifier<NewState> {
  final UserUseCase _userUseCase;

  UserVM(this._userUseCase) : super(NewState.initial()) {
    getUserData();
  }

  Future<void> getUserData() async {
    state = state.copyWith(isLoading: true);
    var data = await _userUseCase.getUserData();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, user: r),
    );
  }
}
