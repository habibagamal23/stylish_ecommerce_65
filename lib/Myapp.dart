import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/core/sherdprf/sherd.dart';
import 'LocalizationLogic/localizatio_cubit.dart';
import 'core/routs/approuter.dart';
import 'core/routs/routs.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<LocalizatioCubit, LocalizatioState>(
      builder: (context, state) {
        final local = state is LocalChange ? state.locale : Locale('en');

        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp(
              locale: local,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              debugShowCheckedModeBanner: false,
              title: 'Stylish',
              initialRoute: isloggin ? Routes.homeScreen : Routes.loginScreen,
              onGenerateRoute: AppRouter.generateRoute,
            );
          },
        );
      },
    );
  }
}

bool isloggin = false;
checkislogin() async {
  String? token = await SharedPrefsHelper.getToken();
  if (token != null && token.isNotEmpty) {
    isloggin = true;
  } else {
    isloggin = false;
  }
}
