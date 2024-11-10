import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/fetures/product/ui/productitemCard.dart';

import '../logic/search_cubit.dart';

class SearchResultsGrid extends StatelessWidget {
  const SearchResultsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      if (state is SearchInitial) {
        return Text("  start search");
      }
      if (state is SearchLoading) {
        return CircularProgressIndicator();
      }
      if (state is SearchSuccess) {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 2.5 / 4),
            itemCount: state.products.length,
            itemBuilder: (context, i) {
              return ProductCard(product: state.products[i]);
            });
      }
      if (state is SearchEmpty) {
        return Text(" empty  search");
      }
      return Text(" search");
    });
  }
}
