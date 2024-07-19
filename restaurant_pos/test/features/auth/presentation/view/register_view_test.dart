import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_pos/config/routes/app_route.dart';
import 'package:restaurant_pos/features/auth/domain/entity/student_entity.dart';
import 'package:restaurant_pos/features/auth/domain/use_case/user_use_case.dart';
import 'package:restaurant_pos/features/auth/presentation/viewmodel/user_view_model.dart';

import 'login_view_test.mocks.dart';

void main() {
  late UserUseCase mockUserUsecase;
  late StudentEntity userEntity;

  setUpAll(() {
    mockUserUsecase = MockUserUseCase();

    userEntity = const StudentEntity(
      id: null,
      fname: 'Nitesh',
      lname: 'Maharjan',
      phone: '98031287598132',
      username: 'Nitesh',
      password: 'Nitesh123',
    );
  });

  testWidgets('register view ...', (tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    when(mockUserUsecase.registerUser(userEntity))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userViewModelProvider.overrideWith(
            (ref) => UserViewModel(mockUserUsecase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.registerViewRoute,
          routes: AppRoute.getAppRoutes(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'Nitesh');

    await tester.enterText(find.byType(TextFormField).at(1), 'Maharjan');

    await tester.enterText(find.byType(TextFormField).at(2), '98031287598132');

    await tester.enterText(find.byType(TextFormField).at(3), 'Nitesh');

    await tester.enterText(find.byType(TextFormField).at(4), 'Nitesh123');

    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Sign UP'),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(5));

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
