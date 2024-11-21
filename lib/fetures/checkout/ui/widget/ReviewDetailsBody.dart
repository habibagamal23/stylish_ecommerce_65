import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/checkout_cubit.dart';

class ReviewDetails extends StatelessWidget {
  const ReviewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return Card(
          // u sholud improve this
          margin: EdgeInsets.all(8),
          elevation: 3,
          child: ListTile(
            title: const Text("Order Details"),
            subtitle:
                Text("Total: ${context.read<CheckoutCubit>().totalPrice}"),
          ),
        );
      },
    );
  }
}
