import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_cubit.dart';
import 'model/cartProduct.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddCartItemSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Item added successfully!")),
          );
        } else if (state is RemoveCartItemSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Item removed successfully!")),
          );
        } else if (state is AddCartItemErrorState || state is RemoveCartItemErrorState) {
          final errorMessage = state is AddCartItemErrorState
              ? state.error
              : (state as RemoveCartItemErrorState).error;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $errorMessage")),
          );
        }
      },
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();

        if (state is GetCartItemLoadingState || state is AddCartItemLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("My Bag"),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  cartCubit.getCartItems();
                },
              ),
            ],
          ),
          body: cartCubit.products.isEmpty
              ? _buildCartEmptyUI(context, cartCubit)
              : _buildCartItemsUI(context, cartCubit, state),
        );
      },
    );
  }

  Widget _buildCartEmptyUI(BuildContext context, CartCubit cartCubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Items(count: cartCubit.products.length),
          Column(
            children: [
              Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
              const Text(
                'No Orders Yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 300,
                child: Text(
                  "Looks like you haven't placed any order yet. Go and enjoy shopping.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Replace with home navigation logic
            },
            child: const Text("Start Shopping"),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemsUI(BuildContext context, CartCubit cartCubit, CartState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: Column(
          children: [
            Items(count: cartCubit.products.length),
            const SizedBox(height: 15),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final product = cartCubit.products[index];
                return BagItem(productItem: product);
              },
              itemCount: cartCubit.products.length,
              separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Subtotal: ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  "\$${cartCubit.totalCartPrice.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: state is AddCartItemLoadingState ? null : () {

              },
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}

class Items extends StatelessWidget {
  final int count;

  const Items({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Items in Cart: ${count ?? 0}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class BagItem extends StatelessWidget {
  final CartProduct productItem;

  const BagItem({Key? key, required this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return ListTile(
      title: Text(productItem.title ?? "Unknown Product"),
      subtitle: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: productItem.quantity > 1
                ? () {
              cartCubit.decreaseItemCountCart(productItem.id, productItem.quantity);
            }
                : null,
          ),
          Text("Quantity: ${productItem.quantity ?? 1}"),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              cartCubit.increaseItemCountCart(productItem.id);
            },
          ),
        ],
      ),
      trailing: Text("\$${(productItem.total ?? 0).toStringAsFixed(2)}"),
    );
  }
}
