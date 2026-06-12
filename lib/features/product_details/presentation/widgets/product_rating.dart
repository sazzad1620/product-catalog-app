import 'package:flutter/material.dart';
import 'package:product_catalog_app/features/products/domain/entities/rating.dart';

class ProductRating extends StatelessWidget {
  final Rating rating;

  const ProductRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    if (rating.rate <= 0 && rating.count <= 0) {
      return const SizedBox.shrink();
    }

    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text(
          rating.rate.toStringAsFixed(1),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
        if (rating.count > 0) ...[
          const SizedBox(width: 4),
          Text(
            '(${rating.count} reviews)',
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }
}
