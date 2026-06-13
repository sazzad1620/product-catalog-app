import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog_app/core/theme/app_colors.dart';
import 'package:product_catalog_app/core/utils/format_price.dart';
import 'package:product_catalog_app/core/widgets/app_bar_divider.dart';
import 'package:product_catalog_app/core/widgets/theme_toggle_button.dart';
import 'package:product_catalog_app/features/product_details/presentation/widgets/product_rating.dart';
import 'package:product_catalog_app/features/products/domain/entities/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: const [ThemeToggleButton()],
        bottom: const AppBarDivider(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'product-${product.id}',
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  height: 220,
                  fit: BoxFit.contain,
                  placeholder: (_, _) => const SizedBox(
                    height: 220,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (_, _, _) => Icon(
                    Icons.image_not_supported_outlined,
                    size: 64,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ProductRating(rating: product.rating),
            const SizedBox(height: 12),
            Text(
              formatPrice(product.price),
              style: textTheme.headlineSmall?.copyWith(
                color: AppColors.priceColor(context),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                product.category,
                style: textTheme.labelSmall?.copyWith(fontSize: 13),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Description',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
