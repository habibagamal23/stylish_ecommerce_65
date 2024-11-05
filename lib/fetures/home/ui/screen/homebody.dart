import 'package:flutter/material.dart';

import '../../../../core/spacing.dart';
import '../widgets/HomeTopBar.dart';
import '../widgets/category_list/categorylistview.dart';
import '../widgets/searchbar.dart';

class Homebody extends StatelessWidget {
  const Homebody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          vertical(20),
          HomeTopBar(),
          vertical(10),
          Searchbar(),
          vertical(20),
          CategoryList(),


        ],

      ),
    );
  }
}
