import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/fetures/cart/model/cartProduct.dart';
import 'package:shtylishecommerce/fetures/checkout/model/PaymentIntentInputModel.dart';
import 'package:shtylishecommerce/fetures/profile-setting/logic/profile_cubit.dart';

import '../../../core/network/stripNetwork/StripApi.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  ProfileCubit profileCubit;
  StripApi stripApi ;

  CheckoutCubit(this.profileCubit , this.stripApi) : super(CheckoutInitial());

  TextEditingController addrescontroller = TextEditingController();
  String addrss = '';

  loadLoacation() {
    if (profileCubit.state is ProfileLoaded) {
      final currentuser = profileCubit.currentUser;
      addrss = currentuser!.address?.address ?? "Unknown";
      addrescontroller.text = addrss;
      emit(AdressLoaded(addrss));
    } else {
      emit(CheckoutInitial());
    }
  }

  setAdrees(String Adress) {
    addrss = Adress;
    addrescontroller.text = Adress;
    emit(AdressUpdated(Adress));
  }

// just for test u sholud complete
  List<CartProduct> cartsProduct = [];
  void addPruduct(CartProduct product) {
    CartProduct? existingProduct;
    try {
      existingProduct = cartsProduct.firstWhere((p) => p.id == product.id);
    } catch (e) {
      existingProduct = null;
    }
    if (existingProduct == null) {
      cartsProduct.add(product);
      emit(AddCarts(product));
    }
  }

  // fuct stripe


  Future MakePymentStrip(PaymentIntentInputModel paymentinput) async {
    emit(PaymentLoading());
    try {
      await stripApi.MakePayment(paymentinput);

      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }


  // total price :
  double totalPrice = 0.0;
  void setTotalPrice(double price) {
    totalPrice = price;
  }

}
