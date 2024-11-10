import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/core/di/di.dart';
import 'package:shtylishecommerce/fetures/product/ui/productitemCard.dart';
import 'package:shtylishecommerce/fetures/search/logic/search_cubit.dart';
import 'package:shtylishecommerce/fetures/search/ui/SearchResultsGrid.dart';

import '../../../core/widgets/Searchbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Searchbar(
          enabled: true,
          onChanged: (query) {
            context.read<SearchCubit>().SearchProduct(query);
          },
        ),
      ),
      body: Column(
        children: [
          Text("Result"),
          Expanded(child:  SearchResultsGrid())
        ],
      )


    );
  }
}
