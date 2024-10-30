part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetProducts extends ProductsEvent {
  const GetProducts();
}

class GetProductById extends ProductsEvent {
  final int id;

  const GetProductById(this.id);

  @override
  List<Object> get props => [id];
}
