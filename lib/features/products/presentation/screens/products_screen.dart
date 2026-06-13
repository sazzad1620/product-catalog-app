import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_app/core/utils/responsive.dart';
import 'package:product_catalog_app/core/widgets/app_bar_divider.dart';
import 'package:product_catalog_app/core/widgets/empty_view.dart';
import 'package:product_catalog_app/core/widgets/error_view.dart';
import 'package:product_catalog_app/core/widgets/loading_view.dart';
import 'package:product_catalog_app/core/widgets/theme_toggle_button.dart';
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
        actions: const [ThemeToggleButton()],
        bottom: const AppBarDivider(),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProductsState state) {
    if (state is ProductsLoading || state is ProductsInitial) {
      return const LoadingView(
        key: ValueKey('loading'),
        message: 'Loading products...',
      );
    }

    if (state is ProductsError) {
      return ErrorView(
        key: const ValueKey('error'),
        message: state.message,
        onRetry: () {
          context.read<ProductsBloc>().add(const RetryFetch());
        },
      );
    }

    if (state is ProductsLoaded) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: CustomScrollView(
          key: const ValueKey('loaded'),
          slivers: [
          SliverToBoxAdapter(
            child: SearchField(
              onChanged: (query) {
                context.read<ProductsBloc>().add(SearchProducts(query));
              },
            ),
          ),
          SliverToBoxAdapter(
            child: SortDropdown(
              sortType: state.sortType,
              onChanged: (sortType) {
                context.read<ProductsBloc>().add(SortProducts(sortType));
              },
            ),
          ),
          ..._buildProductSlivers(context, state),
        ],
        ),
      );
    }

    return const SizedBox.shrink(key: ValueKey('empty'));
  }

  List<Widget> _buildProductSlivers(
    BuildContext context,
    ProductsLoaded state,
  ) {
    if (state.displayedProducts.isEmpty && state.searchQuery.isNotEmpty) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyView(
            message: 'No products found for your search.',
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.all(12),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: getGridCrossAxisCount(context),
            childAspectRatio: 0.72,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final product = state.displayedProducts[index];
              return ProductCard(
                product: product,
                onTap: () {
                  // Full product passed from list; no separate details fetch
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(product: product),
                    ),
                  );
                },
              );
            },
            childCount: state.displayedProducts.length,
          ),
        ),
      ),
    ];
  }
}
