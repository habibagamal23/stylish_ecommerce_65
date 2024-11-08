import 'package:flutter/material.dart';

import '../../model/Product.dart';

class ReviewSection extends StatelessWidget {
  final List<Review> reviews;

  const ReviewSection({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customer Reviews', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 10),
        ...reviews.map((review) => _buildReviewTile(review)).toList(),
      ],
    );
  }

  Widget _buildReviewTile(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 16),
              SizedBox(width: 4),
              Text(review.rating.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Text(review.comment ?? 'No comment provided.'),
          Text(
            '- ${review.reviewerName}',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
