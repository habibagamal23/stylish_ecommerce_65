part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class PaymentLoading extends CheckoutState {}

final class PaymentSuccess extends CheckoutState {}

final class PaymentFailure extends CheckoutState {
  final String errMessage;
  PaymentFailure(this.errMessage);
}


final class AddCarts extends CheckoutState {
  CartProduct product;
  AddCarts(this.product);
}


final class AdressLoaded extends CheckoutState {
  String adress;
  AdressLoaded(this.adress);
}

final class AdressUpdated extends CheckoutState {
  String adress;
  AdressUpdated(this.adress);
}

