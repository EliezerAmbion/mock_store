import 'package:mock_store/domain/repositories/products/products_repository.dart';

class DeleteProductUseCase {
  final ProductsRepository _productsRepository;

  DeleteProductUseCase(this._productsRepository);

  Future<void> call(int id) async {
    return await _productsRepository.deleteProduct(id);
  }
}
