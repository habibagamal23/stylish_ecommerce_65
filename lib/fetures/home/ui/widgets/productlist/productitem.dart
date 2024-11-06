

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../product/model/Product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProductImage(),
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildProductTitle(context),
                SizedBox(height: 2.h),
                _buildProductCategory(),
                SizedBox(height: 2.h),
                _buildProductPrice(),
                SizedBox(height: 3.h),
                _buildProductDescription(),
                SizedBox(height: 3.h),
                _buildProductRating(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      child: Image.network(
        product.images[0],
        height: 100.h,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) =>
        const Icon(Icons.error, size: 40),
      ),
    );
  }

  Widget _buildProductTitle(BuildContext context) {
    return Text(
      product.title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductCategory() {
    return Text(
      product.category??"",
      style: TextStyle(fontSize: 12.sp,
          color: Colors.grey),
    );
  }

  Widget _buildProductPrice() {
    return Row(
      children: [
        Text(
          "₹${product.price.toString()}",
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold, color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(width: 4.w),
        Text(
          "₹${product.discountPercentage.toStringAsFixed(2)}%Off",
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,    overflow: TextOverflow.ellipsis,),
        ),
        SizedBox(width: 2.w),

      ],
    );
  }

  Widget _buildProductDescription() {
    return Text(
      product.description??"",
      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductRating() {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 14.sp),
        SizedBox(width: 4.w),
        Text(
          product.rating.toString(),
          style: TextStyle(fontSize: 12.sp),
        ),
        SizedBox(width: 4.w),
        Text(
          "(${product.rating})",
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
      ],
    );
  }
}