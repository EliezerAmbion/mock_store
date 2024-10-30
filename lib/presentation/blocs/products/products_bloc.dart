import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/domain/usecases/get_product_by_id.usecase.dart';
import 'package:mock_store/domain/usecases/get_products.usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetProductByIdUseCase _getProductByIdUseCase;
  List<ProductsModel> _allProducts = [];

  ProductsBloc(this._getProductsUseCase, this._getProductByIdUseCase)
      : super(ProductsInitial()) {
    on<GetProducts>(onGetProducts);
    on<GetProductById>(onGetProductById);
    on<SearchProducts>(onSearchProducts);
  }

  void onGetProducts(GetProducts event, Emitter<ProductsState> emit) async {
    try {
      final products = await _getProductsUseCase();
      _allProducts = products;

      if (products.isEmpty) {
        emit(const ProductsLoaded([]));
        return;
      }

      emit(ProductsLoaded(products));
      return;
    } catch (e) {
      emit(ProductsError(DioException(
        requestOptions: RequestOptions(path: '/products'),
        error: e.toString(),
      )));
      throw Exception(e.toString());
    }
  }

  void onGetProductById(
      GetProductById event, Emitter<ProductsState> emit) async {
    try {
      final product = await _getProductByIdUseCase(event.id);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductsError(DioException(
        requestOptions: RequestOptions(path: '/products/${event.id}'),
        error: e.toString(),
      )));
    }
  }

  void onSearchProducts(SearchProducts event, Emitter<ProductsState> emit) {
    final query = event.query.toLowerCase();
    if (_allProducts.isNotEmpty) {
      final filteredProducts = _allProducts
          .where((product) => product.title.toLowerCase().contains(query))
          .toList();

      emit(ProductsLoaded(filteredProducts));
    } else {
      emit(const ProductsLoaded([]));
    }
  }
}
