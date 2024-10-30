import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/domain/usecases/get_products.usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase _getProductsUseCase;

  ProductsBloc(this._getProductsUseCase) : super(const ProductsInitial()) {
    on<GetProducts>(onGetProducts);
  }

  void onGetProducts(GetProducts event, Emitter<ProductsState> emit) async {
    emit(const ProductsInitial());

    try {
      // you can use _getProductsUseCase(); or _getProductsUseCase.call();
      final products = await _getProductsUseCase();

      if (products.isEmpty) {
        emit(const ProductsLoaded([]));
        return;
      }

      emit(ProductsLoaded(products));
      return;
    } catch (e) {
      emit(ProductsError(DioException(
        requestOptions: RequestOptions(path: ''),
        error: e.toString(),
      )));
      throw Exception(e.toString());
    }
  }
}
