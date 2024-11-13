part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final Cart cart;
  CartLoadedState(this.cart);
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message);
}

class CartItemAddingState extends CartState {}

class CartItemAddedState extends CartState {
  final Cart cart;
  CartItemAddedState(this.cart);
}

class CartItemRemovingState extends CartState {}

class CartItemRemovedState extends CartState {}

class CartItemUpdatingState extends CartState {}

class CartItemUpdatedState extends CartState {
  final Cart cart;
  CartItemUpdatedState(this.cart);
}

class CartQuantityUpdatedState extends CartState {
  final int quantity;
  CartQuantityUpdatedState(this.quantity);
}
class CartIncrementItemQuantityState extends CartState {}

class CartDecrementItemQuantityState extends CartState {}