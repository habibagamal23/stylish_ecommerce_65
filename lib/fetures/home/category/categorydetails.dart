import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/logic/product_cubit.dart';
import '../../product/model/Product.dart';
import '../ui/widgets/productlist/productitem.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryProductsScreen({Key? key, required this.categoryName}) : super(key: key);

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
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is CategoryProductsLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is CategoryProductsLoaded) {
                return _buildProductGrid(state.categoryProducts);
              } else if (state is CategoryProductsError) {
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

  Widget _buildProductGrid(List<Product> products) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final product = products[index];
            return ProductCard(product: product);
          },
          childCount: products.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.6,
        ),
      ),
    );
  }
}
