import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/home/widgets/products_grid.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isAscending = true;

  @override
  void initState() {
    context.read<ProductsBloc>().add(const GetProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: MediaQuery.sizeOf(context).width * .7,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.white,
              filled: true,
            ),
            onChanged: (value) {
              context.read<ProductsBloc>().add(SearchProducts(value));
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isAscending = !_isAscending;
                });
                context.read<ProductsBloc>().add(SortProducts(_isAscending));
              },
              child: const Icon(Icons.sort),
            ),
          ),
        ],
      ),
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: ProductsGridWidget(products: state.products ?? []),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
