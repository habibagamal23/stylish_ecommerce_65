import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/checkout_cubit.dart';

class ReviewDetails extends StatelessWidget {
  const ReviewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final carts = context.read<CheckoutCubit>().cartsProduct;
        if (carts.isEmpty) {
          return const Center(
            child: Text("No products added to the cart."),
          );
        }
        return Card(
          // u sholud improve this
          margin: EdgeInsets.all(8),
          elevation: 3,
          child: ListTile(
            title: const Text("Order Details"),
            subtitle:
                Text("Name: ${carts.last.title} x ${carts.last.quantity}"),
            trailing: Text("total : ${carts.last.total}"),
          ),
        );
      },
    );
  }
}
