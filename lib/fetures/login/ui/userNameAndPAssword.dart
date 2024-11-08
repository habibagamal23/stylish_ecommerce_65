import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/fetures/login/logic/login_cubit.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/widgets/textfieldcutom.dart';
import '../../../generated/locale_keys.g.dart';

class Usernameandpassword extends StatelessWidget {
  const Usernameandpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: context.read<LoginCubit>().formKey,
        child: Column(
          children: [
            CustomFormTextField(
              hintText: LocaleKeys.Authentication_user_name.tr(),
              labelText: LocaleKeys.Authentication_user_name.tr(),
              controller: context.read<LoginCubit>().username,
            ),
            vertical(10),
            CustomFormTextField(
              hintText: LocaleKeys.Authentication_password.tr(),
              labelText: LocaleKeys.Authentication_password.tr(),
              controller: context.read<LoginCubit>().password,
            ),
          ],
        ));
  }
}
