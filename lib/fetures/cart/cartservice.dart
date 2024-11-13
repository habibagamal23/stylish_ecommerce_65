import 'package:dio/dio.dart';
import 'package:shtylishecommerce/fetures/product/model/Product.dart';

import '../../core/network/Error.dart';
import '../../core/network/constantApi.dart';
import 'cartproduct.dart';
import 'modelcart.dart';

class CartService {
  final Dio _dio;

  CartService(this._dio);

  Future<CartListResponse> fetchCartByUserId(int userId) async {
    try {
      final response = await _dio.get('${ApiConstants.cart}/$userId');
      if (response.statusCode == 200) {
        return CartListResponse.fromJson(response.data);
      } else {
        throw Exception(
            "Failed to fetch carts: Status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception("Unexpected error fetching carts: $e");
    }
  }

  Future<Cart> addProductsToCart({
    required int userId,
    required Product products,
    required int quantity
  }) async {
    try {
      final data = {
        'userId': userId,
        'products': products.toJson(),
        'quantity': quantity
      };

      final response = await _dio.post(
        '${ApiConstants.cart}/add',
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data);
      } else {
        throw Exception(
            "Failed to add products to cart: Status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception("Unexpected error adding products to cart: $e");
    }
  }

  Future<Cart> updateCart({
    required int cartId,
    required CartProduct products,
    bool merge = true,
  }) async {
    try {
      final data = {
        'merge': merge,
        'products': products.toJson(),
      };

      final response = await _dio.put(
        '${ApiConstants.cart}/$cartId',
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data);
      } else {
        throw Exception(
            "Failed to update cart: Status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception("Unexpected error updating cart: $e");
    }
  }

  Future<Cart> deleteCart(int cartId) async {
    try {
      final response = await _dio.delete('${ApiConstants.cart}/$cartId');
      if (response.statusCode == 200) {
        return Cart.fromJson(response.data);
      } else {
        throw Exception(
            "Failed to delete cart: Status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception("Unexpected error deleting cart: $e");
    }
  }
}
