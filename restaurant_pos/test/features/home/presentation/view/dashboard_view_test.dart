import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_pos/config/routes/app_route.dart';

void main() {
  group('dashboard view ...', () {
    testWidgets('Appbar test of dashboard view', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            routes: AppRoute.getAppRoutes(),
            initialRoute: AppRoute.dashboardViewRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.widgetWithText(AppBar, "Home Page"), findsOneWidget);
    });

    testWidgets('bottom navigation icon test of dashboard view', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            routes: AppRoute.getAppRoutes(),
            initialRoute: AppRoute.dashboardViewRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.widgetWithIcon(BottomNavigationBar, Icons.home), findsOneWidget);
    });
  });
}
