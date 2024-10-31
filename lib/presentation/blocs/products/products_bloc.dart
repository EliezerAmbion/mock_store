import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/domain/usecases/add_product.usecase.dart';
import 'package:mock_store/domain/usecases/delete_product.usecase.dart';
import 'package:mock_store/domain/usecases/get_products.usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

enum Sorting { ascending, descending, lowToHigh, highToLow }

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase _getProductsUseCase;
  final AddProductUseCase _addProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  List<ProductsModel> _allProducts = [];
  bool _isDataLoaded = false;
  Sorting _sorting = Sorting.ascending;

  ProductsBloc(this._getProductsUseCase, this._addProductUseCase,
      this._deleteProductUseCase)
      : super(const ProductsInitial()) {
    on<GetProducts>(onGetProducts);
    on<SearchProducts>(onSearchProducts);
    on<SortProductsByTitle>(onSortProductsByTitle);
    on<SortProductsByPrice>(onSortProductsByPrice);
    on<WishlistProduct>(onWishlist);
    on<AddProduct>(onAddProduct);
    on<DeleteProduct>(onDeleteProduct);
  }

  void onGetProducts(GetProducts event, Emitter<ProductsState> emit) async {
    if (_isDataLoaded) return;

    try {
      final products = await _getProductsUseCase();
      _allProducts = products;

      emit(products.isEmpty
          ? const ProductsLoaded([])
          : _sortProducts(products));
      _isDataLoaded = true;
    } catch (e) {
      emit(_handleError(e));
    }
  }

  void onAddProduct(AddProduct event, Emitter<ProductsState> emit) async {
    try {
      final addedProduct = await _addProductUseCase(event.product);
      _allProducts.add(addedProduct);

      emit(const ProductAddedSuccessful(true));
      emit(_sortProducts(_allProducts));
    } catch (e) {
      emit(_handleError(e));
    }
  }

  void onDeleteProduct(DeleteProduct event, Emitter<ProductsState> emit) async {
    try {
      await _deleteProductUseCase(event.id);
      _allProducts.removeWhere((product) => product.id == event.id);
      emit(const ProductDeletedSuccessful(true));
      emit(_sortProducts(_allProducts));
    } catch (e) {
      emit(_handleError(e));
    }
  }

  void onSearchProducts(SearchProducts event, Emitter<ProductsState> emit) {
    final query = event.query.toLowerCase();
    final filteredProducts = _allProducts
        .where((product) => product.title.toLowerCase().contains(query))
        .toList();

    emit(_sortProducts(filteredProducts.isNotEmpty ? filteredProducts : []));
  }

  void onSortProductsByTitle(
      SortProductsByTitle event, Emitter<ProductsState> emit) {
    _sorting =
        event.isAscendingByTitle ? Sorting.ascending : Sorting.descending;
    emit(_sortProducts(_allProducts));
  }

  void onSortProductsByPrice(
      SortProductsByPrice event, Emitter<ProductsState> emit) {
    _sorting = event.isAscendingByPrice ? Sorting.lowToHigh : Sorting.highToLow;
    emit(_sortProducts(_allProducts));
  }

  void onWishlist(WishlistProduct event, Emitter<ProductsState> emit) {
    final updatedProduct = event.product.copyWith(
      isWishListed: !event.product.isWishListed,
    );

    _allProducts = _allProducts.map((product) {
      return product == event.product ? updatedProduct : product;
    }).toList();

    emit(_sortProducts(_allProducts));
  }

  ProductsState _sortProducts(List<ProductsModel> products) {
    final sortedProducts = List<ProductsModel>.from(products);

    switch (_sorting) {
      case Sorting.ascending:
        sortedProducts.sort((a, b) => a.title.compareTo(b.title));
        break;
      case Sorting.descending:
        sortedProducts.sort((a, b) => b.title.compareTo(a.title));
        break;
      case Sorting.lowToHigh:
        sortedProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case Sorting.highToLow:
        sortedProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
    }

    return ProductsLoaded(sortedProducts);
  }

  ProductsError _handleError(dynamic error) {
    return ProductsError(DioException(
      requestOptions: RequestOptions(path: '/products'),
      error: error.toString(),
    ));
  }

  List<ProductsModel> get wishListedProducts {
    return _allProducts.where((product) => product.isWishListed).toList();
  }

  Sorting get currentSorting => _sorting;
}
