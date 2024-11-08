import 'package:flutter/material.dart';

class ProductImageViewer extends StatelessWidget {
  final List<String> images;

  const ProductImageViewer({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.network(
            images[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.error)),
          );
        },
      ),
    );
  }
}
