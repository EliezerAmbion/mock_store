import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/home/widgets/add_product_dialog.widget.dart';
import 'package:mock_store/presentation/screens/home/widgets/products_grid.widget.dart';

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
      body: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    state.error.toString(),
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
          } else if (state is ProductsLoaded) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: ProductsGridWidget(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context, builder: (_) => const AddProductDialogWidget());
        },
      ),
    );
  }
}
