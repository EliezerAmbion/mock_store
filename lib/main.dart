import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/app_bloc_injection.dart';
import 'package:mock_store/utils/dependency_injection.dart';
import 'package:mock_store/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocInjection.getProviders(),
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Mock Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}