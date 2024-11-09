import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/Product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  int quantity = 1;
  double totalPrice = 0.0;

  void initializeQuantityAndPrice(Product product) {
    quantity = 1;
    totalPrice = product.price;
    emit(ProductQuantityUpdated(quantity, totalPrice));
  }

  void incrementQuantity(Product product) {
    if (quantity < product.stock) {
      quantity++;
      totalPrice = quantity * product.price;
      emit(ProductQuantityUpdated(quantity, totalPrice));
    }
  }

  void decrementQuantity(Product product) {
    if (quantity > 1) {
      quantity--;
      totalPrice = quantity * product.price;
      emit(ProductQuantityUpdated(quantity, totalPrice));
    }
  }
}
