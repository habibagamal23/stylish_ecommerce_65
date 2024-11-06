part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class CategoryProductsInitial extends ProductState {}
class CategoryProductsLoading extends ProductState {}  // New state for category loading

class CategoryProductsLoaded extends ProductState {
  final List<Product> categoryProducts;
  CategoryProductsLoaded(this.categoryProducts);
}
class CategoryProductsError extends ProductState {
  final String msg;
  CategoryProductsError(this.msg);
}