import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/core/helpers/colors.dart';
import 'package:shtylishecommerce/core/helpers/extention.dart';
import 'package:shtylishecommerce/core/routs/routs.dart';
import 'package:shtylishecommerce/core/widgets/cusombutton.dart';
import 'package:shtylishecommerce/fetures/product/ui/widgets/ProductImageViewer.dart';
import 'package:shtylishecommerce/fetures/product/ui/widgets/ProductInfoSection.dart';
import 'package:shtylishecommerce/fetures/product/ui/widgets/ReviewSection.dart';
import 'package:shtylishecommerce/fetures/product/ui/widgets/name_rating.dart';
import 'package:shtylishecommerce/generated/locale_keys.g.dart';
import '../../../core/di/di.dart';
import '../../../core/helpers/spacing.dart';
import '../../home/logic/logic_categories/CategoriesCubit.dart';
import '../logic/product_cubit.dart';
import '../model/Product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageViewer(images: product.images),
            vertical(20),
            NameRating(
              product: product,
            ),
            vertical(20),
            ProductInfoSection(product: product),
            vertical(20),
            Text('Description', style: Theme.of(context).textTheme.titleSmall),
            Text(product.description ?? 'No description available'),
            vertical(20),
            ReviewSection(reviews: product.reviews),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Colors.grey),
            iconSize: 24.sp,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CustomButton(
                  text: LocaleKeys.homepage_buy_now.tr(),
                  onPressed: () {
                    context.pushNamed(Routes.checkoutScreen);
                  }),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CustomButton(text: "Add to cart", onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
