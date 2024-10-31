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

  void onAddProduct(AddProduct event, Emitter<ProductsState> emit) async {
    try {
      final addedProduct = await _addProductUseCase(event.product);
      _allProducts.add(addedProduct);

      final sortedProducts = List<ProductsModel>.from(_allProducts)
        ..sort((a, b) => a.price.compareTo(b.price));

      emit(const ProductAddedSuccessful(true));
      emit(ProductsLoaded(List.from(sortedProducts)));
    } catch (e) {
      emit(ProductsError(DioException(
        requestOptions: RequestOptions(path: '/products'),
        error: e.toString(),
      )));
    }
  }

  void onDeleteProduct(DeleteProduct event, Emitter<ProductsState> emit) async {
    try {
      await _deleteProductUseCase(event.id);

      _allProducts.removeWhere((product) => product.id == event.id);

      emit(const ProductDeletedSuccessful(true));
      emit(ProductsLoaded(List.from(_allProducts)));
    } catch (e) {
      emit(ProductsError(DioException(
        requestOptions: RequestOptions(path: '/products'),
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

  void onSortProductsByTitle(
      SortProductsByTitle event, Emitter<ProductsState> emit) {
    final sortedProducts = List<ProductsModel>.from(_allProducts);

    if (event.isAscendingByTitle) {
      _sorting = Sorting.ascending;
      sortedProducts.sort((a, b) {
        return a.title.compareTo(b.title);
      });
    }
    if (!event.isAscendingByTitle) {
      _sorting = Sorting.descending;
      sortedProducts.sort((a, b) {
        return b.title.compareTo(a.title);
      });
    }

    emit(ProductsLoaded(sortedProducts));
  }

  void onSortProductsByPrice(
      SortProductsByPrice event, Emitter<ProductsState> emit) {
    final sortedProducts = List<ProductsModel>.from(_allProducts);

    if (event.isAscendingByPrice) {
      _sorting = Sorting.lowToHigh;
      sortedProducts.sort((a, b) {
        return a.price.compareTo(b.price);
      });
    }
    if (!event.isAscendingByPrice) {
      _sorting = Sorting.highToLow;
      sortedProducts.sort((a, b) {
        return b.price.compareTo(a.price);
      });
    }

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
    if (_sorting == Sorting.ascending) {
      sortedProducts.sort((a, b) {
        return a.title.compareTo(b.title);
      });
    }
    if (_sorting == Sorting.descending) {
      sortedProducts.sort((a, b) {
        return b.title.compareTo(a.title);
      });
    }
    if (_sorting == Sorting.lowToHigh) {
      sortedProducts.sort((a, b) {
        return a.price.compareTo(b.price);
      });
    }
    if (_sorting == Sorting.highToLow) {
      sortedProducts.sort((a, b) {
        return b.price.compareTo(a.price);
      });
    }

    emit(ProductsLoaded(sortedProducts));
  }

  List<ProductsModel> get wishListedProducts {
    return _allProducts.where((product) => product.isWishListed).toList();
  }

  Sorting get currentSorting => _sorting;
}
