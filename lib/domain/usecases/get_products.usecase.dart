import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/domain/repositories/products/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository _productRepository;

  GetProductsUseCase(this._productRepository);

  Future<List<ProductsModel>> call() {
    return _productRepository.getProducts();
  }
}
