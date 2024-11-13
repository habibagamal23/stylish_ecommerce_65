import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/fetures/profile-setting/logic/profile_cubit.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  ProfileCubit profileCubit;

  CheckoutCubit(this.profileCubit) : super(CheckoutInitial());

  TextEditingController addrescontroller = TextEditingController();
  String addrss = '';

  loadLoacation() {
    if (profileCubit.state is ProfileLoaded) {
      final currentuser = profileCubit.currentUser;
      addrss = currentuser!.address?.address ?? "Unknown";  // Optional chaining in case address is null
      addrescontroller.text = addrss;
      emit(AdressLoaded(addrss));
    } else {
      emit(CheckoutInitial());
    }
  }

  setAdrees(String Adress){
    addrss= Adress;
    addrescontroller.text = Adress;
    emit(AdressUpdated(Adress));
  }

}
