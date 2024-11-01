import 'dart:io';

import 'package:mock_store/data/datasources/products/products_datasource.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/domain/repositories/products/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsService _productsService;

  ProductsRepositoryImpl(this._productsService);

  @override
  Future<List<ProductsModel>> getProducts() async {
    try {
      final response = await _productsService.getProducts();

      if (response.response.statusCode != HttpStatus.ok) {
        throw Exception(
            'Failed to load products. Error: ${response.response.statusCode}');
      }

      final List<ProductsModel> products = response.data;
      return products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ProductsModel> addProduct(ProductsModel product) async {
    try {
      final response = await _productsService.addProduct(product.toJson());

      if (response.response.statusCode != HttpStatus.ok) {
        throw Exception(
            'Failed to add product. Error: ${response.response.statusCode}');
      }

      return response.data;
    } catch (e) {
      throw Exception('Error adding product: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    try {
      final response = await _productsService.deleteProduct(id);

      if (response.response.statusCode != HttpStatus.ok) {
        throw Exception(
            'Failed to delete product. Error: ${response.response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting product: ${e.toString()}');
    }
  }
}
