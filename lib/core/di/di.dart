import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shtylishecommerce/core/network/AuthService.dart';
import 'package:shtylishecommerce/core/network/DioFactory.dart';
import 'package:shtylishecommerce/core/network/HoemSevice.dart';
import 'package:shtylishecommerce/fetures/home/logic/home_cubit.dart';
import 'package:shtylishecommerce/fetures/login/logic/login_cubit.dart';

final gitit = GetIt.instance;

void setypGitit() {
  gitit.registerLazySingleton<Dio>(() => DioFcatory.getDio());

  ///  login
  gitit.registerLazySingleton<AuthService>(() => AuthService(gitit<Dio>()));
  gitit.registerFactory<LoginCubit>(() => LoginCubit(gitit<AuthService>()));

  //// home
  gitit.registerLazySingleton<HomeService>(() => HomeService(gitit<Dio>()));
  gitit.registerFactory<HomeCubit>(() => HomeCubit(gitit<HomeService>()));
}
