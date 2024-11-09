
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/fetures/product/model/Product.dart';

import '../../../../core/helpers/spacing.dart';

class NameRating extends StatelessWidget {
 final Product product;
  const NameRating({super.key ,  required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontSize: 20.sp),
        ),
        vertical(8),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 18.sp),
            Text(
              '${product.rating} (${product.reviews.length} reviews)',
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
          ],
        ),
        vertical(8),
        Text(
          '\$${product.price} (-${product.discountPercentage}%)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        Text(
          'Stock: ${product.stock}',
          style: TextStyle(
            color: product.stock > 5 ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
