import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shtylishecommerce/fetures/product/ui/productitemCard.dart';
import 'package:shtylishecommerce/fetures/product/ui/widgets/productsShimmer.dart';

import '../../../../product/ui/productdetaileScreen.dart';
import '../../../logic/logic_home/home_cubit.dart';

class TopHomeProduct extends StatelessWidget {
  const TopHomeProduct({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeLoading) {
      //task add shimmer
        return CircularProgressIndicator();
      }
      if (state is HomeSucces) {
        return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: state.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 2.5 / 4),
            itemBuilder: (contxt, index) =>
                ProductCard(product: state.products[index]));
      }
      return Text("no Product");
    });
  }
}
