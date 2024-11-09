import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/core/network/HoemSevice.dart';

import '../../../product/model/Product.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInitial()) {
    loadHomeData();
  }

  List<String> categories = [];
  List<Product> products = [];

  Future<void> loadHomeData() async {
    if (categories.isNotEmpty && products.isNotEmpty)
      return;
    emit(HomeLoading());
    try {
      categories = await homeService.getAllCategories();
      products = await homeService.getLimitedSortedProducts();
      emit(HomeSucces(categories, products));
    } catch (e) {
      emit(HomeErorr("Failed to load home data: ${e.toString()}"));
    }
  }
}
