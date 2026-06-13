import 'package:product_catalog_app/features/products/domain/entities/product.dart';
import 'package:product_catalog_app/features/products/domain/repositories/product_repository.dart';

class FakeProductRepository implements ProductRepository {
  FakeProductRepository({
    this.products = const [],
    this.throwOnFetch = false,
  });

  final List<Product> products;
  final bool throwOnFetch;

  @override
  Future<List<Product>> getProducts() async {
    if (throwOnFetch) {
      throw Exception('Network error');
    }
    return products;
  }
}
