import 'package:equatable/equatable.dart';
import 'package:product_catalog_app/features/products/domain/entities/product.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_event.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  // Source list preserved; filter and sort affect display only
  final List<Product> allProducts;
  final List<Product> displayedProducts;
  final String searchQuery;
  final SortType? sortType;

  const ProductsLoaded({
    required this.allProducts,
    required this.displayedProducts,
    required this.searchQuery,
    this.sortType,
  });

  @override
  List<Object?> get props =>
      [allProducts, displayedProducts, searchQuery, sortType];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError({required this.message});

  @override
  List<Object?> get props => [message];
}
