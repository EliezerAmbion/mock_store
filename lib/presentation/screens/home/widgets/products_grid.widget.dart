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

          return LayoutBuilder(builder: (context, constraints) {
            int crossAxisCount;
            double horizontalPadding;
            double titleSize;

            if (constraints.maxWidth < 700) {
              crossAxisCount = 2;
              horizontalPadding = 5;
              titleSize = 14;
            } else if (constraints.maxWidth < 900) {
              crossAxisCount = 3;
              horizontalPadding = 50;
              titleSize = 16;
            } else {
              crossAxisCount = 4;
              horizontalPadding = 100;
              titleSize = 18;
            }

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  sliver: SliverGrid.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductsItemWidget(
                        product: products[index],
                        titleSize: titleSize,
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 3 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  ),
                ),
              ],
            );
          });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
