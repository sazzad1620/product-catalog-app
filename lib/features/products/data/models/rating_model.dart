import 'package:product_catalog_app/features/products/domain/entities/rating.dart';

class RatingModel {
  final double rate;
  final int count;

  const RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }

  Rating toEntity() => Rating(rate: rate, count: count);
}
