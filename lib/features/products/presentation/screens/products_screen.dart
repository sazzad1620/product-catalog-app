import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_app/core/widgets/empty_view.dart';
import 'package:product_catalog_app/core/widgets/error_view.dart';
import 'package:product_catalog_app/core/widgets/loading_view.dart';
import 'package:product_catalog_app/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_event.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_state.dart';
import 'package:product_catalog_app/features/products/presentation/widgets/product_card.dart';
import 'package:product_catalog_app/features/products/presentation/widgets/search_field.dart';
import 'package:product_catalog_app/features/products/presentation/widgets/sort_dropdown.dart';

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
            return Column(
              children: [
                SearchField(
                  onChanged: (query) {
                    context.read<ProductsBloc>().add(SearchProducts(query));
                  },
                ),
                SortDropdown(
                  sortType: state.sortType,
                  onChanged: (sortType) {
                    context.read<ProductsBloc>().add(SortProducts(sortType));
                  },
                ),
                Expanded(
                  child: _buildProductBody(context, state),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProductBody(BuildContext context, ProductsLoaded state) {
    if (state.displayedProducts.isEmpty && state.searchQuery.isNotEmpty) {
      return const EmptyView(
        message: 'No products found for your search.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: state.displayedProducts.length,
      itemBuilder: (context, index) {
        final product = state.displayedProducts[index];
        return ProductCard(
          product: product,
          onTap: () {
            // Full product data passed from list response
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(product: product),
              ),
            );
          },
        );
      },
    );
  }
}
