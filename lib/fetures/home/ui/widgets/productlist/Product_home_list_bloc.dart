import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/fetures/product/ui/productitem.dart';
import 'package:shtylishecommerce/fetures/product/ui/widgets/productsShimmer.dart';

import '../../../../product/ui/productdetailes.dart';
import '../../../logic/logic_home/home_cubit.dart';

class TopHomeProduct extends StatelessWidget {
  const TopHomeProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 2.5 / 4,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) => const ProductShimmerLoading(),
          );
        } else if (state is HomeErorr) {
          return Center(
            child: Text(state.msg, style: TextStyle(color: Colors.red)),
          );
        } else if (state is HomeSucces) {
          final productsToShow = state.products.take(4).toList();

          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.5 / 4,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productsToShow.length,
            itemBuilder: (context, index) {
              final product = productsToShow[index];
              return ProductCard(product: product);
            },
          );
        } else {
          return const Center(child: Text("No products available"));
        }
      },
    );
  }
}
