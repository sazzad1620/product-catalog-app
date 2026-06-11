import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_app/core/widgets/error_view.dart';
import 'package:product_catalog_app/core/widgets/loading_view.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_event.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_state.dart';
import 'package:product_catalog_app/features/products/presentation/widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          // Initial state shown as loading until first fetch completes
          if (state is ProductsLoading || state is ProductsInitial) {
            return const LoadingView(message: 'Loading products...');
          }

          if (state is ProductsError) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<ProductsBloc>().add(const RetryFetch());
              },
            );
          }

          if (state is ProductsLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: state.products[index]);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
