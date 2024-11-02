import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110.w,
      height: 90.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: CircleAvatar(
              radius: 35.r,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          SizedBox(height: 5.h),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 60.w,
              height: 10.h,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}
