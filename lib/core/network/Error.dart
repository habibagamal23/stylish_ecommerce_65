import 'package:dio/dio.dart';

Exception handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      return Exception("Connection error: ${e.message}");
    case DioExceptionType.badResponse:
      return Exception("Invalid response: ${e.response?.data}");
    default:
      return Exception("Load error: ${e.message}");
  }
}
// if (e.type == DioExceptionType.connectionError) {
//   throw Exception("Connection error: ${e.message}");
// } else if (e.type == DioExceptionType.badResponse) {
//   throw Exception("Invalid response: ${e.response?.data}");
// } else {
//   throw Exception("Load error: ${e.message}");
// }