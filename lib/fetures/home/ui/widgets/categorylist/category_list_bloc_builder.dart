import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/fetures/home/ui/widgets/categorylist/shimmer_category_item.dart';
import 'package:shtylishecommerce/fetures/home/logic/home_cubit.dart';
import 'category_item.dart';

class CategorysListView extends StatelessWidget {
  const CategorysListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return SizedBox(
            height: 150.h,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.45,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return const ShimmerLoading();
              },
            ),
          );
        }
        if (state is HomeSucces) {
          return SizedBox(
            height: 150.h,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.catigoris.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.45,
              ),
              itemBuilder: (context, index) {
                return HomeCategory(category: state.catigoris[index]);
              },
            ),
          );
        }
        if (state is HomeErorr) {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
