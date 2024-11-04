
import 'package:flutter/material.dart';
import 'package:shtylishecommerce/core/spacing.dart';

import '../widgets/HomeTopBar.dart';
import '../widgets/category_list/categorylistview.dart';
import '../widgets/searchbar.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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


            ],
          
          ),
        ),
      ),
    );
  }
}
