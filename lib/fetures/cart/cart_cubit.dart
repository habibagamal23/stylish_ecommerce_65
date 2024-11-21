import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/core/network/cartService.dart';
import 'model/cartModel.dart';
import 'model/cartProduct.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartService cartService;

  CartCubit(this.cartService) : super(CartInitial());

  List<CartProduct> products = [];
  double totalCartPrice = 0;
  int cartid = 1;

  Future<void> getCartItems() async {
    emit(GetCartItemLoadingState());
    try {
      final fetchedCart = await cartService.fetchCart();
      if (fetchedCart.products == null || fetchedCart.products.isEmpty) {
        products = [];
        totalCartPrice = 0.0;
      } else {
        products = fetchedCart.products.map((product) {
          product.quantity = product.quantity ?? 1;
          product.total = product.total ?? (product.quantity * product.price);
          return product;
        }).toList();
        totalCartPrice = fetchedCart.total ?? 0.0;
        cartid = fetchedCart.id;
      }
      emit(GetCartItemSuccessState(fetchedCart));
    } catch (error) {
      print("Error fetching cart: $error");
      emit(GetCartItemErrorState("Failed to fetch cart items."));
    }
  }

  Future<void> addItemToCart(CartProduct product) async {
    emit(AddCartItemLoadingState());
    try {
      final existingProduct = products.firstWhereOrNull((p) => p.id == product.id);

      if (existingProduct != null) {
        existingProduct.quantity += 1;
        existingProduct.total = existingProduct.quantity * existingProduct.price;
      } else {
        products.add(product);
      }

      _updateCartTotals();
      await cartService.updateCart(cartid, products);

      emit(AddCartItemSuccessState());
    } catch (error) {
      print("Error adding item to cart: $error");

      emit(AddCartItemErrorState("Failed to add item to cart."));
    }
  }

  Future<void> removeItemFromCart(int productId) async {
    emit(RemoveCartItemLoadingState());
    try {
      products.removeWhere((product) => product.id == productId);
      _updateCartTotals();

      await cartService.removeProductFromCart(cartid, productId);
      emit(RemoveCartItemSuccessState());
    } catch (error) {
      emit(RemoveCartItemErrorState("Failed to remove item from cart."));
    }
  }

  Future<void> increaseItemCountCart(int productId) async {
    emit(UpdateItemCountLoadingState());
    try {
      final product = products.firstWhere((p) => p.id == productId);
      product.quantity += 1;
      product.total = product.quantity * product.price;

      await cartService.updateCart(cartid, products);
      _updateCartTotals();

      emit(UpdateItemCountSuccessState());
    } catch (error) {

      emit(UpdateItemCountErrorState("Failed to increase item count."));
    }
  }

  Future<void> decreaseItemCountCart(int productId, int currentCount) async {
    emit(UpdateItemCountLoadingState());
    try {
      if (currentCount > 1) {
        final product = products.firstWhere((p) => p.id == productId);
        product.quantity -= 1;
        product.total = product.quantity * product.price;

        await cartService.updateCart(cartid, products);
        _updateCartTotals();
      } else {
        await removeItemFromCart(productId);
      }
      emit(UpdateItemCountSuccessState());
    } catch (error) {
      emit(UpdateItemCountErrorState("Failed to decrease item count."));
    }
  }

  void _updateCartTotals() {
    totalCartPrice = products.fold(0.0, (sum, item) => sum + item.total);
  }
}
