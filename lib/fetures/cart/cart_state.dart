part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

// States for fetching cart items
class GetCartItemLoadingState extends CartState {}

class GetCartItemSuccessState extends CartState {
  final Cart cart;

  GetCartItemSuccessState(this.cart);
}

class GetCartItemErrorState extends CartState {
  final String error;

  GetCartItemErrorState(this.error);
}

// States for adding an item to the cart
class AddCartItemLoadingState extends CartState {}

class AddCartItemSuccessState extends CartState {}

class AddCartItemErrorState extends CartState {
  final String error;

  AddCartItemErrorState(this.error);
}

// States for removing an item from the cart
class RemoveCartItemLoadingState extends CartState {}

class RemoveCartItemSuccessState extends CartState {}

class RemoveCartItemErrorState extends CartState {
  final String error;

  RemoveCartItemErrorState(this.error);
}

// States for updating item count in the cart
class UpdateItemCountLoadingState extends CartState {}

class UpdateItemCountSuccessState extends CartState {}

class UpdateItemCountErrorState extends CartState {
  final String error;

  UpdateItemCountErrorState(this.error);
}
