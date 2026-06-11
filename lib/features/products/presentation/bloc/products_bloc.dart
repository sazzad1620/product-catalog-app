import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_event.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository repository;

  ProductsBloc({required this.repository}) : super(const ProductsInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<RetryFetch>(_onFetchProducts); // Same handler as initial fetch
  }

  Future<void> _onFetchProducts(
    ProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsLoading());

    try {
      final products = await repository.getProducts();
      emit(ProductsLoaded(products: products));
    } catch (_) {
      emit(
        const ProductsError(
          message: 'Unable to load products. Please check your connection.',
        ),
      );
    }
  }
}
