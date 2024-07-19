import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_pos/core/failure/failure.dart';
import 'package:restaurant_pos/features/auth/domain/entity/student_entity.dart';
import 'package:restaurant_pos/features/auth/domain/use_case/user_use_case.dart';
import 'package:restaurant_pos/features/auth/presentation/viewmodel/user_view_model.dart';

import 'auth_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UserUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late UserUseCase mockUserUsecase;
  late ProviderContainer container;
  late BuildContext context;

  setUpAll(() {
    mockUserUsecase = MockUserUseCase();
    context = MockBuildContext();
    container = ProviderContainer(
      overrides: [
        userViewModelProvider.overrideWith(
          (ref) => UserViewModel(mockUserUsecase),
        ),
      ],
    );
  });

  test('check for the inital state', () async {
    final authState = container.read(userViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  // ======================= Login unit test =============================
  group("Login test", () {
    test('login test with valid username and', () async {
      when(mockUserUsecase.loginUser('Nitesh', 'Nitesh123'))
          .thenAnswer((_) => Future.value(const Right(true)));

      when(mockUserUsecase.loginUser('Nitesh', 'Nitesh1234'))
          .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

      await container
          .read(userViewModelProvider.notifier)
          .loginUser(context, 'Nitesh', 'Nitesh123');

      final authState = container.read(userViewModelProvider);

      expect(authState.error, isNull);
    });

    test('check for invalid username and password ', () async {
      when(mockUserUsecase.loginUser('Nitesh', 'Nitesh1234'))
          .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

      await container
          .read(userViewModelProvider.notifier)
          .loginUser(context, 'Nitesh', 'Nitesh1234');

      final authState = container.read(userViewModelProvider);

      expect(authState.error, 'Invalid');
    });
  });

  // ======================= Register unit test ==============================
  test('Register for valid username and password ', () async {
    var user = const StudentEntity(
      fname: "Nitesh",
      lname: "Maharjan",
      phone: "9812350213",
      image: '',
      username: "Nitesh",
      password: "Nitesh123",
    );

    when(mockUserUsecase.registerUser(user))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(userViewModelProvider.notifier)
        .registerUser(context, user);

    final authState = container.read(userViewModelProvider);

    expect(authState.error, isNull);
  });

  tearDownAll(
    () => container.dispose(),
  );
}
