part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<Cart> items;
  final double totalPrice;
  final double selectedTotalPrice;

  CartLoadedState({
    required this.items,
    required this.totalPrice,
    required this.selectedTotalPrice,
  });
}

class CartErrorState extends CartState {
  final String msg;
  CartErrorState(this.msg);
}
