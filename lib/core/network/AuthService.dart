import 'package:dio/dio.dart';
import 'package:shtylishecommerce/core/network/constantApi.dart';
import 'package:shtylishecommerce/fetures/login/model/LoginBodyRequest.dart';
import 'package:shtylishecommerce/fetures/login/model/loginrespone.dart';
import 'Error.dart';

class AuthService {
  final Dio _dio;
  AuthService(this._dio);


  Future<LoginResponse?> login(LoginBodyRequest loginBody) async {
    try {
      final res = await _dio.post(
        ApiConstants.login,
        data: loginBody.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
          responseType: ResponseType.json,
        ),
      );

      if (res.statusCode == 200) {
        return LoginResponse.fromJson(res.data);
      } else {
        throw Exception(
            "Failed to login: Received unexpected status code ${res.statusCode}");
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception("Unexpected error occurred during login: $e");
    }
  }
}
