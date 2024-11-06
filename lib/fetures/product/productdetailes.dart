import 'package:flutter/material.dart';

import 'model/Product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.thumbnail ??"",
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "\$${product.price.toString()}",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              product.description??"no ",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "Category: ${product.category}",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              "Rating: ${product.rating} ★",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              "Stock: ${product.stock}",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle add to cart action or similar
              },
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
