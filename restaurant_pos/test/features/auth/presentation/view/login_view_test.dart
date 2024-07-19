import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_pos/config/routes/app_route.dart';
import 'package:restaurant_pos/features/auth/domain/use_case/user_use_case.dart';
import 'package:restaurant_pos/features/auth/presentation/viewmodel/user_view_model.dart';

import 'login_view_test.mocks.dart';



@GenerateNiceMocks([
  MockSpec<UserUseCase>(),
])

void main() {
  late bool isLogin;
  late UserUseCase mockUserUsecase;

  setUpAll(() {
    mockUserUsecase = MockUserUseCase();
    
    isLogin = true;
  });

  testWidgets('login test with username and password and open dashboard',
      (WidgetTester tester) async {

    when(mockUserUsecase.loginUser('Nitesh', 'Nitesh123'))
        .thenAnswer((_) async => Right(isLogin));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userViewModelProvider
              .overrideWith((ref) => UserViewModel(mockUserUsecase))
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginViewRoute,
          routes: AppRoute.getAppRoutes(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Nitesh');

    await tester.enterText(find.byType(TextField).at(1), 'Nitesh123');

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Login'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Home Page'), findsOneWidget);
  });
}
