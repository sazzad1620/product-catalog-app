
import 'package:equatable/equatable.dart';

enum SortType { priceLowToHigh, priceHighToLow }

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductsEvent {
  const FetchProducts();
}

class RetryFetch extends ProductsEvent {
  const RetryFetch();
}

class SearchProducts extends ProductsEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class SortProducts extends ProductsEvent {
  final SortType? sortType;

  const SortProducts(this.sortType);

  @override
  List<Object?> get props => [sortType];
}
