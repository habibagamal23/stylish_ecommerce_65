import 'package:shtylishecommerce/fetures/product/ui/productitem.dart';

import '../product/model/Product.dart';
import 'cartproduct.dart';

class Cart {
  final int id;
  final List<CartProduct> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  Cart({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      products: (json['products'] as List)
          .map((productJson) => CartProduct.fromJson(productJson))
          .toList(),
      total: (json['total'] ?? 0.0).toDouble(),
      discountedTotal: (json['discountedTotal'] ?? 0.0).toDouble(),
      userId: json['userId'],
      totalProducts: json['totalProducts'],
      totalQuantity: json['totalQuantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((product) => product.toJson()).toList(),
      'total': total,
      'discountedTotal': discountedTotal,
      'userId': userId,
      'totalProducts': totalProducts,
      'totalQuantity': totalQuantity,
    };
  }
}

class CartListResponse {
  final List<Cart> carts;
  final int total;
  final int skip;
  final int limit;

  CartListResponse({
    required this.carts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory CartListResponse.fromJson(Map<String, dynamic> json) {
    return CartListResponse(
      carts: (json['carts'] as List)
          .map((cartJson) => Cart.fromJson(cartJson))
          .toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carts': carts.map((cart) => cart.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}



