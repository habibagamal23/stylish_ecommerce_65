import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shtylishecommerce/fetures/login/model/loginreqbody.dart';
import 'package:shtylishecommerce/fetures/login/model/loginrespone.dart';

class DioService {
  final Dio _dio;

  DioService() : _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com')) {
    _dio.interceptors.add(PrettyDioLogger(
      request: true,
      error: true,
      requestBody: true,
      responseBody: true,
      maxWidth: 90,
    ));
  }

  Future<LoginResponse?> login(LoginRequestBody loginbody) async {
    try {
      final res = await _dio.post('/auth/login', data: loginbody.toJson());

      if (res.statusCode == 200 && res.data['token'] != null) {
        return LoginResponse.fromJson(res.data);
      } else {
        print("Filed to login , no token");
      }
    } catch (e) {
      print("Error in Dio ");
      return null;
    }
  }
}
