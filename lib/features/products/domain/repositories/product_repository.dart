import 'package:product_catalog_app/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
