import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = Theme.of(context).elevatedButtonTheme.style ??
        ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.mainRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        );

    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: ElevatedButton(
        style: buttonStyle.copyWith(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style:
              Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 16.sp),
        ),
      ),
    );
  }
}
