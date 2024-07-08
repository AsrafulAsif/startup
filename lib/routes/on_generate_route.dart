import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:startup/routes/app_routes.dart';
import 'package:startup/routes/unknown_page.dart';
import 'package:startup/screen/auth/login_screen.dart';
import 'package:startup/screen/home/home_screen.dart';
import 'package:startup/screen/notification/notification_screen.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;
    log("RouteGenerator Navigating to route: $route");

    switch (route) {
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.loginPage:
        return MaterialPageRoute(builder: (_) => const Loginscreen());
      case AppRoutes.notificationPage:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      default:
        return errorRoute();
    }
  }

  static Route? errorRoute() =>
      MaterialPageRoute(builder: (_) => const UnknownPage());
}
