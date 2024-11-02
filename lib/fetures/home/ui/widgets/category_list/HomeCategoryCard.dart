import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/core/colors.dart';

import '../../../../../core/spacing.dart';

class HomeCategory extends StatelessWidget {
  final String category;
  final String image;
  final bool isSelected;

  const HomeCategory({
    super.key,
    required this.category,
    required this.image,
    required this.isSelected,
  });

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
          CircleAvatar(
            radius: 35.r,
            backgroundColor:
                isSelected ? ColorsManager.mainBlue : Colors.grey.shade200,
            child: CircleAvatar(
              radius: 32.r,
              backgroundImage: AssetImage(image),
              onBackgroundImageError: (_, __) => const Icon(Icons.error),
            ),
          ),
          vertical(5),
          Text(
            category.toUpperCase(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 11.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? ColorsManager.mainBlue : Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
