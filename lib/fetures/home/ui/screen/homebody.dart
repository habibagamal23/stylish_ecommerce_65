import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/spacing.dart';
import '../../../product/logic/product_cubit.dart';
import '../../category/category_list/categorylistview.dart';
import '../../logic/home_cubit.dart';
import '../widgets/HomeTopBar.dart';
import '../widgets/crouser.dart';
import '../widgets/productlist/tophomeproduct.dart';
import '../widgets/searchbar.dart';
import '../widgets/title_seeall.dart';

class Homebody extends StatelessWidget {
  const Homebody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: gitit<HomeCubit>(),
        ),
        BlocProvider.value(
          value: gitit<ProductCubit>(),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            vertical(20),
            HomeTopBar(),
            vertical(10),
            Searchbar(),
            vertical(20),
            CategoryList(),
            vertical(20),
            BannerCarouselSlider(),
            vertical(20),
            TitleWithActions(
              title: "ALL Features ",
              onviewPressed: () {},
            ),
            TopHomeProduct(),

          ],
        )),
      ),
    );
  }
}
