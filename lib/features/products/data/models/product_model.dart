import 'package:product_catalog_app/features/products/data/models/rating_model.dart';
import 'package:product_catalog_app/features/products/domain/entities/product.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      // Default rating when API omits the field
      rating: json['rating'] != null
          ? RatingModel.fromJson(json['rating'] as Map<String, dynamic>)
          : const RatingModel(rate: 0, count: 0),
    );
  }

  Product toEntity() => Product(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: rating.toEntity(),
      );
}
