import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/widgets/products_item.widget.dart';

class ProductsGridWidget extends StatelessWidget {
  final List<ProductsModel> products;

  const ProductsGridWidget({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
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
        if (state is ProductsLoaded) {
          // final products = state.products ?? [];

          return CustomScrollView(
            slivers: [
              SliverGrid.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductsItemWidget(product: products[index]);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
