import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mock_store/data/datasources/products/products_datasource.dart';
import 'package:mock_store/data/products/products_repository_impl.dart';
import 'package:mock_store/domain/repositories/products/products_repository.dart';
import 'package:mock_store/domain/usecases/get_products.usecase.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Register Dio
  getIt.registerSingleton<Dio>(Dio());

  // Services
  getIt.registerSingleton<ProductsService>(ProductsService(getIt()));

  // Implementations
  getIt.registerSingleton<ProductsRepository>(ProductsRepositoryImpl(getIt()));

  // UseCases
  getIt.registerSingleton<GetProductsUseCase>(GetProductsUseCase(getIt()));

  // Blocs
  getIt.registerFactory<ProductsBloc>(() => ProductsBloc(getIt()));
}
