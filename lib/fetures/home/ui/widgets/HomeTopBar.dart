import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../LocalizationLogic/localizatio_cubit.dart';
import '../../../../core/spacing.dart';
import '../../../../generated/assets.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          Row(
            children: [
              Image.asset(
                Assets.imagesLogo,
                height: 40.0.h,
              ),
              horizontalSpace(30),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              final cubit = context.read<LocalizatioCubit>();
              cubit.changeLanguage();
              final newLocale = cubit.newLocale;
              context.setLocale(newLocale);
            },
          )
        ],
      ),
    );
  }
}
