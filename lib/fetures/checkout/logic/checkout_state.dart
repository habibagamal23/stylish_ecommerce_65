part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

class AddressLoadedState extends CheckoutState {
  final Address? address;
  AddressLoadedState(this.address);
}

class AddressUpdatedState extends CheckoutState {
  final String department;
  final String street;
  final String city;

  AddressUpdatedState({required this.department, required this.street, required this.city});
}