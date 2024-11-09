import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/HoemSevice.dart';
import '../../../product/model/Product.dart';

part 'CategorieState.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  HomeService homeService;
  CategoriesCubit(this.homeService) : super(CategoryProductsInitial());
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
