class UserState {
  final bool isLoading;
  final String? error;
  final String? imageName;

  UserState({
    required this.isLoading,
    this.error,
    this.imageName,
  });

  factory UserState.initial() {
    return UserState(
      isLoading: false,
      error: null,
      imageName: '',
    );
  }

  UserState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  String toString() => 'UserState(isLoading: $isLoading, error: $error, imageName: $imageName)';
}
