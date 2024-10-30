part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  final List<ProductsModel>? products;
  final DioException? error;

  const ProductsState({this.products, this.error});

  @override
  List<Object> get props => [products ?? [], error ?? 'Error'];
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial() : super();
}

final class ProductsLoaded extends ProductsState {
  const ProductsLoaded(List<ProductsModel> products)
      : super(products: products);
}

final class ProductsError extends ProductsState {
  const ProductsError(DioException error) : super(error: error);
}
