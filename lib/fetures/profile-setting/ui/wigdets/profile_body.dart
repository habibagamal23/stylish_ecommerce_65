import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/fetures/profile-setting/logic/profile_cubit.dart';
import 'package:shtylishecommerce/fetures/profile-setting/ui/wigdets/profile_image.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/cusombutton.dart';
import '../../../../core/widgets/textfieldcutom.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../model/user.dart';

class ProfileBody extends StatelessWidget {
  final User user;

  const ProfileBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ProfileImage(
            imageUrl: user.image,
            onImagePicked: (path) => cubit.updateProfile(imageUrl: path),
          ),
          vertical(20),
          CustomFormTextField(
            hintText: LocaleKeys.Authentication_user_name.tr(),
            labelText: LocaleKeys.Authentication_user_name.tr(),
            controller: cubit.usernameController,
          ),
          vertical(20),
          CustomFormTextField(
            hintText: LocaleKeys.Authentication_enterEmail.tr(),
            labelText: LocaleKeys.Authentication_enterEmail.tr(),
            controller: cubit.emailController,
          ),
          vertical(20),
          CustomFormTextField(
            isObscureText: true,
            hintText: LocaleKeys.Authentication_password.tr(),
            labelText: LocaleKeys.Authentication_password.tr(),
            controller: cubit.passwordController,
          ),
          vertical(20),
          CustomButton(
            text: LocaleKeys.homepage_save_change.tr(),
            onPressed: cubit.updateProfile,
          ),
        ],
      ),
    );
  }
}
