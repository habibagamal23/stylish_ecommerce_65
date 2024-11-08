import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/core/di/di.dart';
import 'package:shtylishecommerce/core/routs/routs.dart';
import 'package:shtylishecommerce/fetures/home/logic/home_cubit.dart';
import 'package:shtylishecommerce/fetures/login/logic/login_cubit.dart';
import 'package:shtylishecommerce/fetures/product/logic/product_cubit.dart';
import 'package:shtylishecommerce/fetures/product/model/Product.dart';
import 'package:shtylishecommerce/fetures/profile-setting/logic/profile_cubit.dart';
import 'package:shtylishecommerce/fetures/profile-setting/ui/profilesetting.dart';

import '../../fetures/home/ui/screen/category_products_screen.dart';
import '../../fetures/home/ui/screen/HomeScreen.dart';
import '../../fetures/home/ui/screen/homebody.dart';
import '../../fetures/login/ui/LoginScreen.dart';
import '../../fetures/product/ui/productdetailes.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => gitit<LoginCubit>(),
            child: const Loginscreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => gitit<HomeCubit>(),
                  child: const Homebody(),
                ));
      case Routes.profileScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => gitit<ProfileCubit>()..loadProfile(),
                child: const ProfileScreen()));

      case Routes.productDetailsScreen:
        return MaterialPageRoute(
          builder: (_) =>
              ProductDetailsScreen(product: settings.arguments as Product),
        );

      case Routes.categoriesScreenDeatiles:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: gitit<ProductCubit>(),
                  child: CategoryProductsScreen(
                      categoryName: settings.arguments as String),
                ));

      default:
        return null;
    }
  }
}
