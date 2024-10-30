part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  LoginResponse loginResponse;
  LoginSuccess(this.loginResponse);
}

final class LoginError extends LoginState {
  String meg;
  LoginError(this.meg);
}
