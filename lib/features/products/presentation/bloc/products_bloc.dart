import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_app/features/products/domain/entities/product.dart';
import 'package:product_catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_event.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository repository;

  ProductsBloc({required this.repository}) : super(const ProductsInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<RetryFetch>(_onFetchProducts); // Same handler as initial fetch
    on<SearchProducts>(_onSearchProducts);
    on<SortProducts>(_onSortProducts);
  }

  Future<void> _onFetchProducts(
    ProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsLoading());

    try {
      final products = await repository.getProducts();
      emit(
        ProductsLoaded(
          allProducts: products,
          displayedProducts: products,
          searchQuery: '',
        ),
      );
    } catch (_) {
      emit(
        const ProductsError(
          message: 'Unable to load products. Please check your connection.',
        ),
      );
    }
  }

  void _onSearchProducts(
    SearchProducts event,
    Emitter<ProductsState> emit,
  ) {
    final current = state;
    if (current is! ProductsLoaded) return;

    // In-memory filter; no additional API call
    final displayed = _applyFilterAndSort(
      current.allProducts,
      event.query,
      current.sortType,
    );

    emit(
      ProductsLoaded(
        allProducts: current.allProducts,
        displayedProducts: displayed,
        searchQuery: event.query,
        sortType: current.sortType,
      ),
    );
  }

  void _onSortProducts(
    SortProducts event,
    Emitter<ProductsState> emit,
  ) {
    final current = state;
    if (current is! ProductsLoaded) return;

    final displayed = _applyFilterAndSort(
      current.allProducts,
      current.searchQuery,
      event.sortType,
    );

    emit(
      ProductsLoaded(
        allProducts: current.allProducts,
        displayedProducts: displayed,
        searchQuery: current.searchQuery,
        sortType: event.sortType,
      ),
    );
  }

  List<Product> _applyFilterAndSort(
    List<Product> allProducts,
    String query,
    SortType? sortType,
  ) {
    var result = allProducts;

    if (query.isNotEmpty) {
      final lowerQuery = query.toLowerCase();
      result = result
          .where((p) => p.title.toLowerCase().contains(lowerQuery))
          .toList();
    }

    if (sortType != null) {
      result = List<Product>.from(result);
      if (sortType == SortType.priceLowToHigh) {
        result.sort((a, b) => a.price.compareTo(b.price));
      } else {
        result.sort((a, b) => b.price.compareTo(a.price));
      }
    }

    return result;
  }
}
