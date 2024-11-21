class CartProduct {
  final int id;
  final String title;
  final double price;
   int quantity;
   double total;
  final double discountPercentage;
  final double discountedTotal;
  final String? thumbnail;

  CartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    this.thumbnail,
  });

  /// Factory method to create a `CartProduct` from JSON.
  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      title: json['title'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 0,
      total: (json['total'] ?? 0.0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0.0).toDouble(),
      discountedTotal: (json['discountedTotal'] ?? 0.0).toDouble(),
      thumbnail: json['thumbnail'],
    );
  }

  /// Method to convert a `CartProduct` instance to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'quantity': quantity,
      'total': total,
      'discountPercentage': discountPercentage,
      'discountedTotal': discountedTotal,
      'thumbnail': thumbnail,
    };
  }

  /// Copy method to create a new `CartProduct` with updated fields.
  CartProduct copyWith({
    int? id,
    String? title,
    double? price,
    int? quantity,
    double? total,
    double? discountPercentage,
    double? discountedTotal,
    String? thumbnail,
  }) {
    return CartProduct(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountedTotal: discountedTotal ?? this.discountedTotal,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

}
