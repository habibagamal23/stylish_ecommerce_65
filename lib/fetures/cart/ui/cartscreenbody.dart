import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart_cubit.dart';
import 'cartitem.dart';

class CartScreen extends StatelessWidget {
  final int userId;

  const CartScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartErrorState) {
            return Center(
                child:
                    Text(state.message, style: TextStyle(color: Colors.red)));
          } else if (state is CartLoadedState) {
            final cart = state.cart;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.products.length,
                    itemBuilder: (context, index) {
                      final product = cart.products[index];
                      return CartItemWidget(product: product);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total:"),
                          Text("\$${cart.total.toStringAsFixed(2)}"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
// Handle checkout
                        },
                        child: const Text("Proceed to Checkout"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No items in cart"));
          }
        },
      ),
    );
  }
}
