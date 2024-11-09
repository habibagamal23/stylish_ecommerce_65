part of 'CategoriesCubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoryProductsInitial extends CategoriesState {}
class CategoryProductsLoading extends CategoriesState {}  // New state for category loading

class CategoryProductsLoaded extends CategoriesState {
  final List<Product> categoryProducts;
  CategoryProductsLoaded(this.categoryProducts);
}
class CategoryProductsError extends CategoriesState {
  final String msg;
  CategoryProductsError(this.msg);
}
