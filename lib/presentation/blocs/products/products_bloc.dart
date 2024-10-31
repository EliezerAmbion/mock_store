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
  bool _isAscending = true;
  bool _isDataLoaded = false;

  ProductsBloc(this._getProductsUseCase, this._getProductByIdUseCase)
      : super(const ProductsInitial()) {
    on<GetProducts>(onGetProducts);
    on<GetProductById>(onGetProductById);
    on<SearchProducts>(onSearchProducts);
    on<SortProducts>(onSortProducts);
    on<WishlistProduct>(onWishlist);
  }

  void onGetProducts(GetProducts event, Emitter<ProductsState> emit) async {
    if (_isDataLoaded) return;

    try {
      final products = await _getProductsUseCase();
      _allProducts = products;

      if (products.isEmpty) {
        emit(const ProductsLoaded([]));
        return;
      }

      final sortedProducts = List<ProductsModel>.from(products)
        ..sort((a, b) => a.price.compareTo(b.price));

      emit(ProductsLoaded(sortedProducts));
      _isDataLoaded = true;
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

  void onSortProducts(SortProducts event, Emitter<ProductsState> emit) {
    _isAscending = event.isAscending;
    final sortedProducts = List<ProductsModel>.from(_allProducts);

    sortedProducts.sort((a, b) {
      return _isAscending
          ? a.price.compareTo(b.price)
          : b.price.compareTo(a.price);
    });

    emit(ProductsLoaded(sortedProducts));
  }

  void onWishlist(WishlistProduct event, Emitter<ProductsState> emit) {
    final updatedProduct = event.product.copyWith(
      isWishListed: !event.product.isWishListed,
    );

    _allProducts = _allProducts.map((product) {
      return product == event.product ? updatedProduct : product;
    }).toList();

    final sortedProducts = List<ProductsModel>.from(_allProducts);
    sortedProducts.sort((a, b) {
      return _isAscending
          ? a.price.compareTo(b.price)
          : b.price.compareTo(a.price);
    });

    emit(ProductsLoaded(sortedProducts));
  }
}
