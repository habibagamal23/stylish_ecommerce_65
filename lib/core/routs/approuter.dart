import 'package:flutter/material.dart';
import 'package:shtylishecommerce/core/routs/routs.dart';

import '../../fetures/login/ui/LoginScreen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => Loginscreen(),
        );

      default:
        return null;
    }
  }
}
