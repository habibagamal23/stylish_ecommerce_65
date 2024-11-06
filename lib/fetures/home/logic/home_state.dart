part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSucces extends HomeState {
  List<String> catigoris;
  final List<Product> products;
  HomeSucces(this.catigoris, this.products);
}

final class HomeErorr extends HomeState {
  String msg;
  HomeErorr(this.msg);
}
