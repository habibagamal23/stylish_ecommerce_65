import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/core/di/di.dart';
import 'package:shtylishecommerce/fetures/cart/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: gitit<CartCubit>()..getCartItems,
      child: CartScreen(),
    );
  }
}
