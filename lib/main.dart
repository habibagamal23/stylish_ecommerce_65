import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/LocalizationLogic/localizatio_cubit.dart';
import 'package:shtylishecommerce/core/di/di.dart';
import 'package:shtylishecommerce/core/network/AuthService.dart';
import 'package:shtylishecommerce/fetures/login/logic/login_cubit.dart';

import 'Myapp.dart';
import 'core/sherdprf/sherd.dart';
import 'fetures/checkout/logic/checkout_cubit.dart';
import 'fetures/home/logic/logic_home/home_cubit.dart';
import 'generated/codegen_loader.g.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  await SharedPrefsHelper.init();
  await EasyLocalization.ensureInitialized();

  setypGitit();
  await checkislogin();

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
    assetLoader: CodegenLoader(),
    child: MultiBlocProvider(providers: [
      BlocProvider<LocalizatioCubit>(create: (_) => LocalizatioCubit()),
      BlocProvider(
        create: (context) =>gitit<CheckoutCubit>()..loadLoacation(),  // Provide CheckoutCubit here
        child: MyApp(),
      ),

    ], child: MyApp()),
  ));
}
