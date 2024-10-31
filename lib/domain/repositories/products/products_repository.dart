import 'package:mock_store/data/models/products/products.model.dart';

abstract class ProductsRepository {
  Future<List<ProductsModel>> getProducts();
  // Future<ProductsModel> addProduct(ProductsModel product);
}
