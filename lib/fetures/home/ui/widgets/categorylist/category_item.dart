import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/core/helpers/extention.dart';
import 'package:shtylishecommerce/core/routs/routs.dart';

import '../../../../product/logic/product_cubit.dart';

class HomeCategory extends StatelessWidget {
  final String category;
  const HomeCategory({
    super.key,
    required this.category,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final productCubit = context.read<ProductCubit>();
        productCubit.getProductWithCategoryName(category);
        context.pushNamed(Routes.categoriesScreenDeatiles, arguments: category);
      },
      child: Container(
        width: 220.w,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  category,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 4.h),
                Text(
                  "See more ",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 16.sp,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
