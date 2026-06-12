import 'package:flutter/material.dart';
import 'package:product_catalog_app/core/theme/app_colors.dart';
import 'package:product_catalog_app/features/products/domain/entities/rating.dart';

class ProductRating extends StatelessWidget {
  final Rating rating;

  const ProductRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    if (rating.rate <= 0 && rating.count <= 0) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text(
          rating.rate.toStringAsFixed(1),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        if (rating.count > 0) ...[
          const SizedBox(width: 4),
          Text(
            '(${rating.count} reviews)',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }
}
