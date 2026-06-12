import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_app/core/theme/app_theme.dart';
import 'package:product_catalog_app/core/theme/app_theme_scope.dart';
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

class ProductCatalogApp extends StatefulWidget {
  final ProductRepository repository;

  const ProductCatalogApp({super.key, required this.repository});

  @override
  State<ProductCatalogApp> createState() => _ProductCatalogAppState();
}

class _ProductCatalogAppState extends State<ProductCatalogApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeScope(
      themeMode: _themeMode,
      toggleTheme: _toggleTheme,
      child: BlocProvider(
        create: (_) =>
            ProductsBloc(repository: widget.repository)..add(const FetchProducts()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Product Catalog',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeMode,
          home: const ProductsScreen(),
        ),
      ),
    );
  }
}
