import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/core/network/dio_service.dart';
import 'package:shtylishecommerce/core/sherdprf/sherd.dart';
import 'package:shtylishecommerce/fetures/login/model/loginreqbody.dart';
import 'package:shtylishecommerce/fetures/login/model/loginrespone.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final DioService _dioService;
  LoginCubit(this._dioService) : super(LoginInitial());

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(LoginLoading());
    try {
      final loginbody =
          LoginRequestBody(username: username.text, password: password.text);
      final LoginResponse? response = await _dioService.login(loginbody);

      if (response != null) {
        await SharedPrefsHelper.setToken(response.token);
        emit(LoginSuccess(response!));
      } else {
        emit(LoginError(" error For response is null "));
      }
    } catch (e) {
      emit(LoginError("Login error $e"));
    }
  }
}
