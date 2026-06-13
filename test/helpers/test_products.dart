import 'package:product_catalog_app/features/products/domain/entities/product.dart';
import 'package:product_catalog_app/features/products/domain/entities/rating.dart';

const testRating = Rating(rate: 4.5, count: 10);

Product testProduct({
  required int id,
  required String title,
  required double price,
}) {
  return Product(
    id: id,
    title: title,
    price: price,
    description: 'Test description',
    category: 'test',
    image: 'https://example.com/image.png',
    rating: testRating,
  );
}

List<Product> sampleProducts() {
  return [
    testProduct(id: 1, title: 'Fjallraven Backpack', price: 109.95),
    testProduct(id: 2, title: 'Mens Cotton Jacket', price: 55.99),
  ];
}
