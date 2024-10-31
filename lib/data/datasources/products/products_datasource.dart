import 'package:dio/dio.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/utils/constants.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'products_datasource.g.dart';

@RestApi(baseUrl: productsBaseURL)
abstract class ProductsService {
  factory ProductsService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ProductsService;

  @GET('/products')
  Future<HttpResponse<List<ProductsModel>>> getProducts();

  @POST('/products')
  Future<HttpResponse<ProductsModel>> addProduct(
      @Body() Map<String, dynamic> product);

  @DELETE('/products/{id}')
  Future<HttpResponse<void>> deleteProduct(@Path("id") int id);
}
