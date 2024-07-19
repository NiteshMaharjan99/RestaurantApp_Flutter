import 'package:restaurant_pos/features/auth/presentation/view/login_view.dart';
import 'package:restaurant_pos/features/auth/presentation/view/register_view.dart';
import 'package:restaurant_pos/features/home/presentation/view/dashboard_view.dart';
import 'package:restaurant_pos/features/splash/presentation/view/splash_view.dart';

class AppRoute{
  AppRoute._();

  static String loginViewRoute = '/loginViewRoute';
  static String registerViewRoute = '/registerViewRoute';
  static String dashboardViewRoute = "/dashboardViewRoute";
  static String splashRoute = '/splashRoute';

   static getAppRoutes() {
    return {
      loginViewRoute: (context) => const LoginView(),
      registerViewRoute: (context) => const RegisterView(),
      dashboardViewRoute: (context) => const DashboardView(),
      splashRoute: (context) => const SplashView(),
    };
   }

}