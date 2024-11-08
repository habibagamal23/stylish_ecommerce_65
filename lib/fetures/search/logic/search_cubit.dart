import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/core/network/HoemSevice.dart';

import '../../product/model/Product.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  HomeService homeService;
  SearchCubit(this.homeService) : super(SearchInitial());



  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(SearchEmpty());
      return;
    }

    emit(SearchLoading());

    try {
      final products = await homeService.searchProducts(query);
      if (products.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchSuccess(products));
      }
    } catch (e) {
      emit(SearchError("Failed to load search results: ${e.toString()}"));
    }
  }
}
