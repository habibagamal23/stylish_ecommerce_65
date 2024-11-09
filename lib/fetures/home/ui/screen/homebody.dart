import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/core/helpers/extention.dart';
import 'package:shtylishecommerce/core/routs/routs.dart';
import 'package:shtylishecommerce/generated/locale_keys.g.dart';

import '../../../../core/di/di.dart';
import '../../../../core/helpers/spacing.dart';
import '../../logic/logic_categories/CategoriesCubit.dart';
import '../widgets/categorylist/category_list_bloc_builder.dart';
import '../../logic/logic_home/home_cubit.dart';
import '../widgets/HomeTopBar.dart';
import '../widgets/BannerCarouselSlider.dart';
import '../widgets/productlist/Product_home_list_bloc.dart';
import '../../../../core/widgets/Searchbar.dart';
import '../widgets/TitleWithActions.dart';

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
          value: gitit<CategoriesCubit>(),
        ),
      ],
      child: Scaffold(
        drawer: Drawer(
          child: drawerCustom(context),
        ),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: HomeTopBar(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              vertical(8),
              Searchbar(
                enabled: false,
                onTap: () {
                  context.pushNamed(Routes.searchScreen);
                },
              ),
              vertical(20),
              const CategorysListView(),
              vertical(20),
              const BannerCarouselSlider(),
              vertical(20),
              TitleWithActions(
                title: LocaleKeys.homepage_all_featured.tr(),
                onviewPressed: () {},
              ),
              const TopHomeProduct(),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerCustom(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.red),
          child: Center(
            child: Text(
              LocaleKeys.homepage_menu.tr(),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text(
            LocaleKeys.homepage_profile_setting.tr(),
          ),
          onTap: () {
            context.pushNamed(Routes.profileScreen);
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: Text(
            LocaleKeys.homepage_cart.tr(),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: Text(
            LocaleKeys.homepage_wishlist.tr(),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
