import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'apiconsumer.dart';

class DioApiConsumer implements ApiConsumer {
  final Dio dio;

  DioApiConsumer(this.dio) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        request: true,
        error: true,
        responseBody: true,
      ),
    );
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          contentType: contentType ?? Headers.jsonContentType,
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception("GET request failed: $e");
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          contentType: contentType ?? Headers.jsonContentType,
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception("POST request failed: $e");
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          contentType: contentType ?? Headers.jsonContentType,
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception("PUT request failed: $e");
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          contentType: contentType ?? Headers.jsonContentType,
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception("DELETE request failed: $e");
    }
  }
}
