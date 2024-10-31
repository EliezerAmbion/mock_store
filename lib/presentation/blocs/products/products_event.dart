part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
  @override
  List<Object?> get props => [];
}

class GetProducts extends ProductsEvent {
  const GetProducts();
}

class SearchProducts extends ProductsEvent {
  final String query;

  const SearchProducts(this.query);
  @override
  List<Object> get props => [query];
}

class SortProducts extends ProductsEvent {
  final bool isAscending;

  const SortProducts(this.isAscending);
  @override
  List<Object> get props => [isAscending];
}

class WishlistProduct extends ProductsEvent {
  final ProductsModel product;

  const WishlistProduct(this.product);

  @override
  List<Object> get props => [product];
}

class AddProduct extends ProductsEvent {
  final ProductsModel product;

  const AddProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProduct extends ProductsEvent {
  final int id;

  const DeleteProduct(this.id);

  @override
  List<Object> get props => [id];
}
