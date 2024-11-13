import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/fetures/product/ui/productitem.dart';

import '../product/model/Product.dart';
import 'cartproduct.dart';
import 'cartservice.dart';
import 'modelcart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartService cartService;

  CartCubit(this.cartService) : super(CartInitial());

  List<CartProduct> products = [];
  int totalCartPrice = 0;

  // Fetch Cart Items for a specific user
  Future<void> getCartItems(int userId) async {
    emit(CartLoadingState());
    try {
      final cartResponse = await cartService.fetchCartByUserId(userId);
      products = cartResponse.carts.first
          .products; // Assuming we only want the latest cart's products
      totalCartPrice = cartResponse.carts.first.total.toInt();
      emit(CartLoadedState(cartResponse.carts.first));
    } catch (error) {
      emit(CartErrorState("Failed to fetch cart items: ${error.toString()}"));
    }
  }

  // Add a Product to the Cart
  Future<void> addItemToCart({
    required int userId,
    required Product product,
    required int quantity,
  }) async {
    emit(CartLoadingState());
    try {
      final updatedCart = await cartService.addProductsToCart(
        userId: userId,
        products: product,
        quantity: quantity, // Specify quantity
      );
      emit(CartItemAddedState(updatedCart));
    } catch (error) {
      emit(CartErrorState("Failed to add item to cart: ${error.toString()}"));
    }
  }
  // Remove a Product from the Cart
  Future<void> removeItemFromCart(int cartId, CartProduct product) async {
    emit(CartItemRemovingState());
    try {
      await cartService.deleteCart(cartId);
      emit(CartItemRemovedState());
      getCartItems(cartId); // Refresh cart after removal
    } catch (error) {
      emit(CartErrorState(
          "Failed to remove item from cart: ${error.toString()}"));
    }
  }
  void updateQuantity(int quantity) {
    emit(CartQuantityUpdatedState(quantity));
  }
  // Update the quantity of a Product in the Cart
  Future<void> updateItemQuantity(
      int cartId, CartProduct product, int quantity) async {
    emit(CartItemUpdatingState());
    try {
      final updatedCart = await cartService.updateCart(
        cartId: cartId,
        products: product,
      );
      await getCartItems(cartId); // Refresh the cart after update
      emit(CartItemUpdatedState(updatedCart));
    } catch (error) {
      emit(CartErrorState(
          "Failed to update item quantity: ${error.toString()}"));
    }
  }

  // Increment Item Quantity
  Future<void> incrementItemQuantity(int cartId, CartProduct product) async {
    final currentQuantity = product.quantity + 1; // Update based on your logic
    await updateItemQuantity(cartId, product, currentQuantity);
  }

  // Decrement Item Quantity
  Future<void> decrementItemQuantity(int cartId, CartProduct product) async {
    final currentQuantity = product.quantity - 1; // Update based on your logic
    if (currentQuantity <= 0) {
      await removeItemFromCart(cartId, product);
    } else {
      await updateItemQuantity(cartId, product, currentQuantity);
    }
  }
}
