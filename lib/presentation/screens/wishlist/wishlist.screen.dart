import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/home/widgets/products_item.widget.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoaded) {
            final wishListedProducts =
                context.read<ProductsBloc>().wishListedProducts;

            if (wishListedProducts.isEmpty) {
              return const Center(child: Text('No products in your wishlist.'));
            }
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
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    sliver: SliverGrid.builder(
                      itemCount: wishListedProducts.length,
                      itemBuilder: (context, index) {
                        final product = wishListedProducts[index];
                        return ProductsItemWidget(
                          product: product,
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

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
