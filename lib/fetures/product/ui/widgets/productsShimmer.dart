import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmerLoading extends StatelessWidget {
  const ProductShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image placeholder
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Container(
                height: 130.h,
                width: 156.w,
                color: Colors.grey.shade300,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title placeholder
                  Container(
                    height: 16.h,
                    width: 120.w,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 4.h),
                  // Category placeholder
                  Container(
                    height: 12.h,
                    width: 80.w,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 4.h),
                  // Price placeholder
                  Container(
                    height: 14.h,
                    width: 50.w,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 8.h),
                  // Rating placeholder
                  Row(
                    children: [
                      Container(
                        height: 12.h,
                        width: 20.w,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        height: 12.h,
                        width: 30.w,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
