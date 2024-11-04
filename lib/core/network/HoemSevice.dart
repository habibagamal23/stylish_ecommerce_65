import 'package:dio/dio.dart';
import 'Error.dart';
import 'constantApi.dart';

class HomeService {
  final Dio _dio;
  HomeService(this._dio);
  Future<List<String>> getAllCategories() async {
    try {
      final resp = await _dio.get(ApiConstants.catigoryList);
      if (resp.statusCode == 200) {
        return List<String>.from(resp.data);
      } else {
        throw Exception(
            "Failed to load categories: Status code ${resp.statusCode}");
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception("Unexpected error while loading categories: $e");
    }
  }
}
