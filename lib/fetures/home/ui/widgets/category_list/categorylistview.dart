import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/fetures/home/logic/home_cubit.dart';
import 'package:shtylishecommerce/fetures/home/ui/widgets/category_list/shimmercat.dart';
import 'HomeCategoryCard.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

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
                mainAxisSpacing: 5,
                crossAxisSpacing: 4,
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
                mainAxisSpacing: 5,
                crossAxisSpacing: 4,
                childAspectRatio: 0.45,
              ),
              itemBuilder: (context, index) {
                return HomeCategory(category: state.catigoris[index]);
              },
            ),
          );
        }
        return const Center(
          child: Text("Error"),
        );
      },
    );
  }
}
