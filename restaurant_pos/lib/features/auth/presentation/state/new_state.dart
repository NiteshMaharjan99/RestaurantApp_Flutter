import 'package:restaurant_pos/features/auth/domain/entity/student_entity.dart';

class NewState {
  final bool isLoading;
  final String? error;
  final StudentEntity? user;

  NewState({
    required this.isLoading,
    this.error,
    required this.user,
  });

  factory NewState.initial() {
    return NewState(
      isLoading: false,
      error: null,
      user: null
    );
  }

  NewState copyWith({
    bool? isLoading,
    String? error,
    StudentEntity? user
  }) {
    return NewState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
}
}