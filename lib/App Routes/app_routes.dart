import 'package:flutter/material.dart';
import '../_Root/onBoarding/onBoard.dart';

class AppRoutes {

  // ignore: constant_identifier_names
  static const String Lower_Admin = '/lower_admin.dart';

  //static const String splash = '/splash_page.dart';

  // ignore: constant_identifier_names
  static const String on_Boarding = '/onBoard.dart';

  //static const String splashScreen = '/splash_screen';

  static const String main = '/main.dart';

  static const String loginScreen = '/login_screen';

  static const String dashboardScreen = '/dashboard_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {

    on_Boarding: (context) => const Onboarding_Screen(),

    //main: (context) => main(),

    //splashScreen: (context) => SplashScreen(),
    //regScreen: (context) => RegScreen(),
    //loginScreen: (context) => LoginScreen(),
    //dashboardScreen: (context) => DashboardScreen(),
    //appNavigationScreen: (context) => AppNavigationScreen()
  };
}
