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

class SortProductsByTitle extends ProductsEvent {
  final bool isAscendingByTitle;

  const SortProductsByTitle(this.isAscendingByTitle);
  @override
  List<Object> get props => [isAscendingByTitle];
}

class SortProductsByPrice extends ProductsEvent {
  final bool isAscendingByPrice;

  const SortProductsByPrice(this.isAscendingByPrice);
  @override
  List<Object> get props => [isAscendingByPrice];
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
