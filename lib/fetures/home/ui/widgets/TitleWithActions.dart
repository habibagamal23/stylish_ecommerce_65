import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/locale_keys.g.dart';

class TitleWithActions extends StatelessWidget {
  final String title;
  final VoidCallback onviewPressed;


  const TitleWithActions({
    super.key,
    required this.title,
    required this.onviewPressed,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.sp , vertical: 8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: onviewPressed,
            child: Row(
              children: [
                Text(
                  LocaleKeys.homepage_view_all.tr(),
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                ),
                Icon(Icons.arrow_forward_ios_sharp, size: 17.sp, color: Colors.black),
          
              ],
            ),
          ),
       
        ],
      ),
    );
  }
}