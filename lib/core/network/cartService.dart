import 'package:dio/dio.dart';
import '../../fetures/cart/model/cartModel.dart';
import '../../fetures/cart/model/cartProduct.dart';
import '../sherdprf/sherd.dart';

class CartService {
  final Dio _dio;

  CartService(this._dio);

  /// Fetch the current cart for the logged-in user
  Future<Cart> fetchCart() async {
    try {
      final int? userId = SharedPrefsHelper.getid();
      if (userId == null) {
        throw Exception("No user ID found. Please log in again.");
      }

      final response = await _dio.get('https://dummyjson.com/carts/user/$userId');

      if (response.statusCode == 200) {
        final carts = response.data['carts'] as List?;
        if (carts != null && carts.isNotEmpty) {
          return Cart.fromJson(carts[0]);
        } else {
          throw Exception("No cart data available for user ID $userId.");
        }
      } else {
        throw Exception("Failed to fetch cart. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error occurred while fetching cart: $e");
    }
  }


  /// Add a product to the user's cart
  Future<void> addProductToCart(CartProduct product) async {
    final int? userId = SharedPrefsHelper.getid();
    if (userId == null) {
      throw Exception("No user ID found. Please log in again.");
    }

    final response = await _dio.post(
      'https://dummyjson.com/carts/add',
      data: {
        "userId": userId,
        "products": [
          {
            "id": product.id,
            "quantity": product.quantity,
          }
        ],
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to add product to cart: ${response.statusCode}");
    }
  }

  /// Update a user's cart
  Future<void> updateCart(int cartId, List<CartProduct> products) async {
    final response = await _dio.put(
      'https://dummyjson.com/carts/$cartId',
      data: {
        'merge': true,
        'products': products
            .map((product) => {
          "id": product.id,
          "quantity": product.quantity,
        })
            .toList(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update cart: ${response.statusCode}");
    }
  }

  /// Remove a product from the cart
  Future<void> removeProductFromCart(int cartId, int productId) async {
    final response = await _dio.put(
      'https://dummyjson.com/carts/$cartId',
      data: {
        'merge': true,
        'products': [
          {"id": productId, "quantity": 0}
        ],
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
          "Failed to remove product from cart: ${response.statusCode}");
    }
  }
}
