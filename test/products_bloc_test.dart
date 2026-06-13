import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog_app/features/products/domain/entities/product.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_event.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_state.dart';

import 'helpers/fake_product_repository.dart';
import 'helpers/test_products.dart';

void main() {
  late List<Product> products;

  setUp(() {
    products = sampleProducts();
  });

  blocTest<ProductsBloc, ProductsState>(
    'emits Loading then Loaded when fetch succeeds',
    build: () => ProductsBloc(
      repository: FakeProductRepository(products: products),
    ),
    act: (bloc) => bloc.add(const FetchProducts()),
    expect: () => [
      const ProductsLoading(),
      ProductsLoaded(
        allProducts: products,
        displayedProducts: products,
        searchQuery: '',
      ),
    ],
  );

  blocTest<ProductsBloc, ProductsState>(
    'emits Loading then Error when fetch fails',
    build: () => ProductsBloc(
      repository: FakeProductRepository(throwOnFetch: true),
    ),
    act: (bloc) => bloc.add(const FetchProducts()),
    expect: () => [
      const ProductsLoading(),
      const ProductsError(
        message: 'Unable to load products. Please check your connection.',
      ),
    ],
  );

  blocTest<ProductsBloc, ProductsState>(
    'search filters products by title',
    build: () => ProductsBloc(
      repository: FakeProductRepository(products: products),
    ),
    seed: () => ProductsLoaded(
      allProducts: products,
      displayedProducts: products,
      searchQuery: '',
    ),
    act: (bloc) => bloc.add(const SearchProducts('backpack')),
    expect: () => [
      ProductsLoaded(
        allProducts: products,
        displayedProducts: [products[0]],
        searchQuery: 'backpack',
      ),
    ],
  );

  blocTest<ProductsBloc, ProductsState>(
    'sorts products by price low to high',
    build: () => ProductsBloc(
      repository: FakeProductRepository(products: products),
    ),
    seed: () => ProductsLoaded(
      allProducts: products,
      displayedProducts: products,
      searchQuery: '',
    ),
    act: (bloc) => bloc.add(const SortProducts(SortType.priceLowToHigh)),
    expect: () => [
      ProductsLoaded(
        allProducts: products,
        displayedProducts: [products[1], products[0]],
        searchQuery: '',
        sortType: SortType.priceLowToHigh,
      ),
    ],
  );

  blocTest<ProductsBloc, ProductsState>(
    'default order restores original list order',
    build: () => ProductsBloc(
      repository: FakeProductRepository(products: products),
    ),
    seed: () => ProductsLoaded(
      allProducts: products,
      displayedProducts: [products[1], products[0]],
      searchQuery: '',
      sortType: SortType.priceLowToHigh,
    ),
    act: (bloc) => bloc.add(const SortProducts(null)),
    expect: () => [
      ProductsLoaded(
        allProducts: products,
        displayedProducts: products,
        searchQuery: '',
      ),
    ],
  );
}
