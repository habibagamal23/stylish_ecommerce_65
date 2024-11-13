import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/widgets/textfieldcutom.dart';
import '../addadress/mapscreen.dart';
import '../logic/checkout_cubit.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirm Order")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Delivery Address"),
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
              vertical(20),
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
              ElevatedButton(
                onPressed: () {},
                child: Text("Save Address"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
