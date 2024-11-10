import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/fetures/profile-setting/logic/profile_cubit.dart';
import 'package:shtylishecommerce/fetures/profile-setting/ui/wigdets/profile_body.dart';
import 'package:shtylishecommerce/generated/locale_keys.g.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.homepage_profile_setting.tr()),
          backgroundColor: Colors.red,
        ),
        body:
            BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          if (state is ProfileLoading) {
            return CircularProgressIndicator();
          }
          if (state is ProfileLoaded) {
            return ProfileBody(
              user: state.user,
            );
          }
          return SizedBox.shrink();
        }));
  }
}
