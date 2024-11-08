import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/colors.dart';


class CustomFormTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool isObscureText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomFormTextField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
    required this.labelText,
    required this.controller,
    this.isObscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 16.sp , color: ColorsManager.mainDark),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp ,color: ColorsManager.gray),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: ColorsManager.lightGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: ColorsManager.mainRed),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: ColorsManager.lighterGray,
        contentPadding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 16.w,
        ),
      ),
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12.sp),

    );
  }
}
