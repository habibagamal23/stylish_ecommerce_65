import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/core/di/di.dart';
import 'package:shtylishecommerce/core/routs/routs.dart';
import 'package:shtylishecommerce/fetures/home/logic/home_cubit.dart';
import 'package:shtylishecommerce/fetures/login/logic/login_cubit.dart';

import '../../fetures/home/ui/screen/HomeScreen.dart';
import '../../fetures/login/ui/LoginScreen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => gitit<LoginCubit>(),
            child: Loginscreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) =>  BlocProvider(
          create: (_) => gitit<HomeCubit>(),
          child:Homescreen(),
        ));

      default:
        return null;
    }
  }
}
