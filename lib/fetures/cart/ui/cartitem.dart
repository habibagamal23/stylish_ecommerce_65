import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart_cubit.dart';
import '../cartproduct.dart';

class CartItemWidget extends StatelessWidget {
  final CartProduct product;

  const CartItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              product.thumbnail ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Price: \$${product.price.toStringAsFixed(2)}"),
                  Text("Total: \$${product.total.toStringAsFixed(2)}"),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () =>
                      cartCubit.decrementItemQuantity(product.id, product),
                ),
                Text(product.quantity.toString()),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () =>
                      cartCubit.incrementItemQuantity(product.id, product),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () =>
                  cartCubit.removeItemFromCart(product.id, product),
            ),
          ],
        ),
      ),
    );
  }
}
