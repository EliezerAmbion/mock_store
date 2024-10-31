import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/home/widgets/products_item.widget.dart';
import 'package:mock_store/utils/custom_snackbar.dart';

class ProductsGridWidget extends StatelessWidget {
  const ProductsGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductDeletedSuccessful) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(text: 'Product deleted successfully'),
          );
        }

        if (state is ProductAddedSuccessful) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(text: 'Product added successfully'),
          );
        }

        if (state is ProductsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(text: state.error.toString()),
          );
        }
      },
      builder: (context, state) {
        if (state is ProductsLoaded) {
          final products = state.products ?? [];

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
