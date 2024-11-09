import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/logic_categories/CategoriesCubit.dart';
import '../../../product/ui/productitem.dart';
import '../../../product/ui/widgets/productsShimmer.dart';


class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryProductsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(categoryName),
            floating: true,
            pinned: true,
            expandedHeight: 80.0,
            backgroundColor: Colors.red,
          ),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoryProductsLoading) {
                return SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: 2.5 / 4,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => const ProductShimmerLoading(),
                      childCount: 4,
                    ),
                  ),
                );
              }
              if (state is CategoryProductsLoaded) {
                // Display the actual product grid
                return SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final product = state.categoryProducts[index];
                        return ProductCard(product: product);
                      },
                      childCount: state.categoryProducts.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2.5 / 4,
                    ),
                  ),
                );
              } else if (state is CategoryProductsError) {
                // Error message
                return SliverFillRemaining(
                  child: Center(child: Text(state.msg)),
                );
              } else {
                return const SliverFillRemaining(
                  child: Center(child: Text("No products available")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
