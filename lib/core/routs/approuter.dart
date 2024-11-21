import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/core/di/di.dart';
import 'package:shtylishecommerce/core/routs/routs.dart';
import 'package:shtylishecommerce/fetures/cart/cartscreen.dart';
import 'package:shtylishecommerce/fetures/home/logic/logic_home/home_cubit.dart';
import 'package:shtylishecommerce/fetures/login/logic/login_cubit.dart';
import 'package:shtylishecommerce/fetures/home/logic/logic_categories/CategoriesCubit.dart';
import 'package:shtylishecommerce/fetures/product/model/Product.dart';
import 'package:shtylishecommerce/fetures/profile-setting/logic/profile_cubit.dart';
import 'package:shtylishecommerce/fetures/profile-setting/ui/profilesetting.dart';

import '../../fetures/checkout/ui/checkoutScreen.dart';
import '../../fetures/home/ui/screen/category_products_screen.dart';
import '../../fetures/home/ui/screen/HomeScreen.dart';
import '../../fetures/home/ui/screen/homebody.dart';
import '../../fetures/login/ui/LoginScreen.dart';
import '../../fetures/product/ui/productdetailes.dart';
import '../../fetures/search/logic/search_cubit.dart';
import '../../fetures/search/ui/searchscreen.dart';

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
                  value: gitit<CategoriesCubit>(),
                  child: CategoryProductsScreen(
                      categoryName: settings.arguments as String),
                ));

      case Routes.searchScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => gitit<SearchCubit>(),
                  child: const SearchScreen(),
                ));

      case Routes.checkoutScreen:
        return MaterialPageRoute(
          builder: (_) => const ConfirmOrderScreen(),
        );
      case Routes.cartScreen:
        return MaterialPageRoute(
          builder: (_) =>  CartScreen(),
        );

      default:
        return null;
    }
  }
}
