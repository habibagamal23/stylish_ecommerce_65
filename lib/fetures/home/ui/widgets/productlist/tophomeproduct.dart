import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/fetures/home/ui/widgets/productlist/productitem.dart';
import 'package:shtylishecommerce/fetures/home/ui/widgets/productlist/productsgimer.dart';

import '../../../../product/productdetailes.dart';
import '../../../logic/home_cubit.dart';



class TopHomeProduct extends StatelessWidget {
  const TopHomeProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return SizedBox(
            height: 300, // Set a fixed height for the shimmer loading
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4, // Show 4 shimmer items
              itemBuilder: (context, index) => const ProductShimmerLoading(),
            ),
          );
        } else if (state is HomeErorr) {
          return Center(
            child: Text(state.msg),
          );
        } else if (state is HomeSucces) {
          // Show only the first 4 items or fewer if there are less than 4
          final productsToShow = state.products.take(4).toList();

          return SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productsToShow.length,
              itemBuilder: (context, index) {
                final product = productsToShow[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsScreen(product: product),
                        ),
                      );
                    },
                    child: ProductCard(product: product),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text("No products available"));
        }
      },
    );
  }
}
