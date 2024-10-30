import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/utils/dependency_injection.dart';

class AppBlocInjection {
  static List<BlocProvider> getProviders() {
    return [
      BlocProvider<ProductsBloc>(
        create: (BuildContext context) =>
            getIt<ProductsBloc>()..add(const GetProducts()),
      ),
      // Add other BLoC providers here
    ];
  }
}
