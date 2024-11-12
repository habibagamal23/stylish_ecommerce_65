import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'modelcart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
}
