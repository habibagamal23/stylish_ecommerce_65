import 'package:flutter/material.dart';
import '../../model/Product.dart';

class ProductInfoSection extends StatelessWidget {
  final Product product;

  const ProductInfoSection({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Brand', product.brand),
        _buildInfoRow('SKU', product.sku),
       _buildInfoRow('Warranty', product.warrantyInformation),
        _buildInfoRow('Shipping', product.shippingInformation),
        _buildInfoRow('Availability', product.availabilityStatus),
        _buildInfoRow('Return Policy', product.returnPolicy),
      ],
    );
  }

  Widget _buildInfoRow(String title, String? info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(info ?? 'N/A'),
        ],
      ),
    );
  }
}
