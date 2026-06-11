import 'package:product_catalog_app/features/products/data/datasources/product_remote_datasource.dart';
import 'package:product_catalog_app/features/products/domain/entities/product.dart';
import 'package:product_catalog_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  ProductRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Product>> getProducts() async {
    try {
      final models = await remoteDatasource.fetchProducts();
      // Map to domain entity before returning to presentation
      return models.map((model) => model.toEntity()).toList();
    } catch (_) {
      throw Exception('Failed to load products');
    }
  }
}
