import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'constantApi.dart';

class DioFcatory {
  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      error: true,
      request: true,
    ));
    return dio;
  }
}
