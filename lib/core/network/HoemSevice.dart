import 'package:dio/dio.dart';
import '../../fetures/product/model/Product.dart';
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

  // Function to fetch limited and sorted products
  Future<List<Product>> getLimitedSortedProducts() async {
    try {
      final resp = await _dio.get(
        ApiConstants.products,
        queryParameters: {
          'limit': 5, // Limit to 5 products
          'sortBy': 'title', // Sort by title
          'order': 'asc', // Ascending order
        },
      );

      if (resp.statusCode == 200) {
        return (resp.data['products'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception(
            "Failed to load products: Status code ${resp.statusCode}");
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception("Unexpected error while loading products: $e");
    }
  }

  Future<List<Product>> getProductWithCategoryName(String categoryName) async {
    try {
      final resp = await _dio.get(
        "${ApiConstants.productsbycategory}/${categoryName}",
      );

      if (resp.statusCode == 200) {
        return (resp.data['products'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load products: Status code ${resp.statusCode}");
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception("Unexpected error while loading products: $e");
    }
  }
}
