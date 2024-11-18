import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/widgets/textfieldcutom.dart';
import 'mapscreen.dart';
import '../logic/checkout_cubit.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Delivery Address"),
        Row(
          children: [
            const Text("Find your address from map "),
            IconButton(
              onPressed: () async {
                final location = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(
                      onLocationSelected: (String address) {
                        context.read<CheckoutCubit>().setAdrees(address);
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.location_on),
            ),
          ],
        ),
        vertical(20),
        BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            final cubit = context.read<CheckoutCubit>();
            return CustomFormTextField(
              hintText: 'Address',
              labelText: 'Address',
              controller: cubit.addrescontroller,
            );
          },
        ),
        vertical(20),
      ],
    );
  }
}
