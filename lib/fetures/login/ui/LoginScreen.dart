import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/LocalizationLogic/localizatio_cubit.dart';
import 'package:shtylishecommerce/core/routs/routs.dart';
import 'package:shtylishecommerce/core/widgets/cusombutton.dart';
import 'package:shtylishecommerce/fetures/login/logic/login_cubit.dart';
import 'package:shtylishecommerce/fetures/login/ui/userNameAndPAssword.dart';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/spacing.dart';
import '../../../generated/locale_keys.g.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LocalizatioCubit>();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.language),
                onPressed: () {
                  cubit.changeLanguage();
                  final newLocale = cubit.newLocale;
                  context.setLocale(newLocale);
                },
              ),
            ),
            Text(
              LocaleKeys.Authentication_title_Login.tr(),
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 36.sp, fontWeight: FontWeight.bold),
            ),
            vertical(30),
            const Usernameandpassword(),
            vertical(50),
            BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CustomButton(
                  text: LocaleKeys.Authentication_bottom_login.tr(),
                  onPressed: () {
                    context.read<LoginCubit>().login();
                    Navigator.pushNamed(context, Routes.homeScreen);
                  });
            }, listener: (context, state) {
              if (state is LoginError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.meg),
                  backgroundColor: Colors.red,
                ));
              }

              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Login Succ"),
                  backgroundColor: Colors.green,
                ));
              }
            })
          ],
        ),
      ),
    )));
  }
}
