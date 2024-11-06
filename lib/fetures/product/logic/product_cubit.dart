import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/network/HoemSevice.dart';
import '../model/Product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  HomeService homeService;
  ProductCubit(this.homeService) : super(CategoryProductsInitial());
  Map<String, List<Product>> categoryProductCache = {};

  Future<void> getProductWithCategoryName(String categoryName) async {
    if (categoryProductCache.containsKey(categoryName)) {
      emit(CategoryProductsLoaded(categoryProductCache[categoryName]!));
      return;
    }

    emit(CategoryProductsLoading());
    try {
      final categoryProducts =
          await homeService.getProductWithCategoryName(categoryName);
      categoryProductCache[categoryName] = categoryProducts;
      emit(CategoryProductsLoaded(categoryProducts));
    } catch (e) {
      emit(CategoryProductsError(
          "Failed to load category products: ${e.toString()}"));
    }
  }
}
