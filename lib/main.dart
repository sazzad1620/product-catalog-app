import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_app/core/theme/app_theme.dart';
import 'package:product_catalog_app/features/products/data/datasources/product_remote_datasource.dart';
import 'package:product_catalog_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:product_catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:product_catalog_app/features/products/presentation/bloc/products_event.dart';
import 'package:product_catalog_app/features/products/presentation/screens/products_screen.dart';

void main() {
  final dio = Dio();
  final datasource = ProductRemoteDatasource(dio: dio);
  // Interface type keeps BLoC independent of data layer
  final ProductRepository repository =
      ProductRepositoryImpl(remoteDatasource: datasource);

  runApp(ProductCatalogApp(repository: repository));
}

class ProductCatalogApp extends StatelessWidget {
  final ProductRepository repository;

  const ProductCatalogApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsBloc(repository: repository)..add(const FetchProducts()),
      child: MaterialApp(
        title: 'Product Catalog',
        theme: AppTheme.lightTheme,
        home: const ProductsScreen(),
      ),
    );
  }
}
