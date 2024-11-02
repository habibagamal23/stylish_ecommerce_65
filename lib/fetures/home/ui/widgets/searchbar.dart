import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locale_keys.g.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp),
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: LocaleKeys.homepage_search_bar.tr(),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Icon(Icons.mic, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
