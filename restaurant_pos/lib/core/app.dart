import 'package:flutter/material.dart';
import 'package:restaurant_pos/config/routes/app_route.dart';
import 'package:restaurant_pos/config/theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splashRoute,
      theme: AppTheme.getApplicationTheme(),
      routes: AppRoute.getAppRoutes(),
    );
  }
}
