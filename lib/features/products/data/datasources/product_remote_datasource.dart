import 'package:dio/dio.dart';
import 'package:product_catalog_app/core/constants/api_constants.dart';
import 'package:product_catalog_app/features/products/data/models/product_model.dart';

class ProductRemoteDatasource {
  final Dio dio;

  ProductRemoteDatasource({required this.dio});

  Future<List<ProductModel>> fetchProducts() async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}',
    );

    final data = response.data as List<dynamic>;
    return data
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
