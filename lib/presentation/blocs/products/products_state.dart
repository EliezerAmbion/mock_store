part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<ProductsModel> products;

  const ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductDetailLoaded extends ProductsState {
  final ProductsModel product;

  const ProductDetailLoaded(this.product);

  @override
  List<Object> get props => [product];
}

final class ProductsError extends ProductsState {
  final DioException? errorMessage;

  const ProductsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage ?? 'Error'];
}
