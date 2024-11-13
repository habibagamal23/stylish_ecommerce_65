part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class AdressLoaded extends CheckoutState {
  String adress;
  AdressLoaded(this.adress);
}

final class AdressUpdated extends CheckoutState {
  String adress;
  AdressUpdated(this.adress);
}
