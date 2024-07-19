import 'package:restaurant_pos/features/menu/domain/entity/menu_entity.dart';

class MenuState {
  final bool isLoading;
  final List<MenuEntity> menus;
  final String? error;
  final String? imageName;

  MenuState({
    required this.isLoading,
    required this.menus,
    this.error,
    this.imageName,
  });

  factory MenuState.initial() {
    return MenuState(
      isLoading: false,
      menus: [],
      imageName: '',
    );
  }

  MenuState copyWith({
    bool? isLoading,
    List<MenuEntity>? menus,
    String? error,
    String? imageName
  }) {
    return MenuState(
      isLoading: isLoading ?? this.isLoading,
      menus: menus ?? this.menus,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
    );
  }
  @override
  String toString() => 'MenuState(isLoading: $isLoading, error: $error)';
}
