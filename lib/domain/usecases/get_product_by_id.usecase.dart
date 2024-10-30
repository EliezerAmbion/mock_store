import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/domain/repositories/products/products_repository.dart';

class GetProductByIdUseCase {
  final ProductsRepository _productsRepository;

  GetProductByIdUseCase(this._productsRepository);

  Future<ProductsModel> call(int id) {
    return _productsRepository.getProductById(id);
  }
}
