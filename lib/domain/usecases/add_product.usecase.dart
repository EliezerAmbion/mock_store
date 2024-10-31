import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/domain/repositories/products/products_repository.dart';

class AddProductUseCase {
  final ProductsRepository _productsRepository;

  AddProductUseCase(this._productsRepository);

  Future<ProductsModel> call(ProductsModel product) async {
    return await _productsRepository.addProduct(product);
  }
}
