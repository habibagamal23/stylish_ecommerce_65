import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shtylishecommerce/core/helpers/extention.dart';
import 'package:shtylishecommerce/core/widgets/cusombutton.dart';
import 'package:shtylishecommerce/fetures/cart/cart_cubit.dart';
import 'package:shtylishecommerce/fetures/cart/model/cartProduct.dart';
import 'package:shtylishecommerce/fetures/product/ui/widgets/ProductImageViewer.dart';
import 'package:shtylishecommerce/fetures/product/ui/widgets/ProductInfoSection.dart';
import 'package:shtylishecommerce/fetures/product/ui/widgets/ReviewSection.dart';
import 'package:shtylishecommerce/fetures/product/ui/widgets/name_rating.dart';

import '../../../core/routs/routs.dart';
import '../../checkout/logic/checkout_cubit.dart';
import '../model/Product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? "Unknown Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageViewer(images: product.images),
            const SizedBox(height: 20),
            NameRating(product: product),
            const SizedBox(height: 20),
            ProductInfoSection(product: product),
            const SizedBox(height: 20),
            _buildDescription(context),
            const SizedBox(height: 20),
            ReviewSection(reviews: product.reviews),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('description'.tr(), style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 10),
        Text(product.description ?? 'no_description'.tr()),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    final isLoading = cartCubit.state is AddCartItemLoadingState;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: isLoading ? null : () => _handleAddToCart(context),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("add_to_cart"),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                final cartCubit = context.read<CartCubit>();
                final totalPrice = cartCubit.totalCartPrice;
// push
              },
              child: const Text("Buy Now"),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAddToCart(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final newCartProduct = CartProduct(
      id: product.id,
      title: product.title ?? "Unknown Product",
      price: product.price ?? 0.0,
      quantity: 1,
      total: product.price ?? 0.0,
      discountPercentage: product.discountPercentage ?? 0.0,
      discountedTotal: (product.price ?? 0.0) -
          ((product.price ?? 0.0) *
              ((product.discountPercentage ?? 0.0) / 100)),
    );

    cartCubit.addItemToCart(newCartProduct);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.title} ${'added_to_cart'}"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            cartCubit.removeItemFromCart(product.id);
          },
        ),
      ),
    );
  }
}
