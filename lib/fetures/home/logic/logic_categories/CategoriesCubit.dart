import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/HoemSevice.dart';
import '../../../product/model/Product.dart';

part 'CategorieState.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  HomeService homeService;
  CategoriesCubit(this.homeService) : super(CategoryProductsInitial());

  Future<void> getProductWithCategoryName(String categoryName) async {}
}
