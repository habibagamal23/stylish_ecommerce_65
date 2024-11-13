import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/fetures/checkout/addadress/mapscreen.dart';
import 'package:shtylishecommerce/fetures/checkout/checkout_cubit.dart';
import '../../../core/widgets/textfieldcutom.dart';

class Checkoutscreen extends StatelessWidget {
  const Checkoutscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Address Delivery"),
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
                    icon: const Icon(Icons.location_on)),
              ],
            ),
            BlocBuilder<CheckoutCubit, CheckoutState>(
              builder: (context, state) {
                final cubit = context.read<CheckoutCubit>();
                if (state is AdressLoaded) {
                  return Column(
                    children: [
                      CustomFormTextField(
                        hintText: 'Address',
                        labelText: 'Address',
                        controller: cubit.addrescontroller,
                      )
                    ],
                  );
                }
                if (state is AdressUpdated) {
                  return Column(
                    children: [
                      CustomFormTextField(
                        hintText: 'Address',
                        labelText: 'Address',
                        controller: cubit.addrescontroller,
                      )
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
