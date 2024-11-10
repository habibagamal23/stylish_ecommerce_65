import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/logic_categories/CategoriesCubit.dart';
import '../../../product/ui/productitemCard.dart';
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
        ],
      ),
    );
  }
}
