import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/core/network/AuthService.dart';
import 'package:shtylishecommerce/core/sherdprf/sherd.dart';
import 'package:shtylishecommerce/fetures/login/model/LoginBodyRequest.dart';
import 'package:shtylishecommerce/fetures/login/model/loginrespone.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _dioService;
  LoginCubit(this._dioService) : super(LoginInitial());

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(LoginLoading());

    try {
      final loginBody = LoginBodyRequest(
        username: username.text,
        password: password.text,
      );

      final LoginResponse? response = await _dioService.login(loginBody);
      if (response != null) {
        await SharedPrefsHelper.setToken(response.accessToken);
        emit(LoginSuccess(response));
      } else {
        emit(LoginError("Login failed: Invalid response or empty token"));
      }
    } on DioException catch (e) {
      emit(LoginError("Network error: ${e.message}"));
    } catch (e) {
      emit(LoginError("Unexpected error: $e"));
    }
  }
}
