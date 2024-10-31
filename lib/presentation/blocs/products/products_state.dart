part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  final List<ProductsModel>? products;
  final ProductsModel? product;
  final DioException? error;
  final bool? isAdded;

  const ProductsState({this.products, this.product, this.error, this.isAdded});

  @override
  List<Object> get props => [products ?? [], product ?? [], error ?? 'Error'];
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial() : super();
}

final class ProductsLoaded extends ProductsState {
  const ProductsLoaded(List<ProductsModel> products)
      : super(products: products);
}

class ProductDetailLoaded extends ProductsState {
  const ProductDetailLoaded(ProductsModel product) : super(product: product);
}

final class ProductsError extends ProductsState {
  const ProductsError(DioException error) : super(error: error);
}

final class ProductAddedSuccessful extends ProductsState {
  const ProductAddedSuccessful(bool isAdded) : super(isAdded: isAdded);
}

final class ProductDeletedSuccessful extends ProductsState {
  const ProductDeletedSuccessful(bool isAdded) : super(isAdded: isAdded);
}
