import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shtylishecommerce/core/network/AuthService.dart';
import 'package:shtylishecommerce/core/network/DioFactory.dart';
import 'package:shtylishecommerce/core/network/HoemSevice.dart';
import 'package:shtylishecommerce/fetures/cart/cartservice.dart';
import 'package:shtylishecommerce/fetures/home/logic/logic_home/home_cubit.dart';
import 'package:shtylishecommerce/fetures/login/logic/login_cubit.dart';

import '../../fetures/cart/cart_cubit.dart';
import '../../fetures/checkout/logic/checkout_cubit.dart';
import '../../fetures/home/logic/logic_categories/CategoriesCubit.dart';
import '../../fetures/profile-setting/logic/profile_cubit.dart';
import '../../fetures/search/logic/search_cubit.dart';
import '../network/profile_service.dart';

final gitit = GetIt.instance;

void setypGitit() {
  gitit.registerLazySingleton<Dio>(() => DioFcatory.getDio());

  ///  login
  gitit.registerLazySingleton<AuthService>(() => AuthService(gitit<Dio>()));
  gitit.registerFactory<LoginCubit>(() => LoginCubit(gitit<AuthService>()));

  //// home

  gitit.registerLazySingleton<HomeService>(() => HomeService(gitit<Dio>()));
  gitit.registerLazySingleton<HomeCubit>(() => HomeCubit(gitit<HomeService>()));

  gitit.registerLazySingleton<CategoriesCubit>(
      () => CategoriesCubit(gitit<HomeService>()));

  gitit.registerFactory<SearchCubit>(() => SearchCubit(
      homeCubit: gitit<HomeCubit>(), homeService: gitit<HomeService>()));
// cart
  gitit.registerLazySingleton<CartService>(() => CartService(gitit<Dio>()));
  gitit.registerLazySingleton<CartCubit>(() => CartCubit(gitit<CartService>()));
  //profile
  gitit.registerLazySingleton<ProfileService>(
      () => ProfileService(gitit<Dio>()));
  gitit.registerLazySingleton<ProfileCubit>(
      () => ProfileCubit(gitit<ProfileService>()));


  gitit.registerFactory<CheckoutCubit>(
      () => CheckoutCubit(gitit<ProfileCubit>()));
}
