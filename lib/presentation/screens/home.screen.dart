import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/widgets/products_grid.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(const GetProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    state.errorMessage.toString(),
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
            child: ProductsGridWidget(),
          );
        },
      ),
    );
  }
}
