import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/LocalizationLogic/localizatio_cubit.dart';
import 'package:shtylishecommerce/core/di/di.dart';
import 'package:shtylishecommerce/core/network/AuthService.dart';
import 'package:shtylishecommerce/fetures/login/logic/login_cubit.dart';

import 'Myapp.dart';
import 'core/sherdprf/sherd.dart';
import 'fetures/home/logic/home_cubit.dart';
import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    ], child: MyApp()),
  ));
}
