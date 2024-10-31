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

            return CustomScrollView(
              slivers: [
                SliverGrid.builder(
                  itemCount: wishListedProducts.length,
                  itemBuilder: (context, index) {
                    final product = wishListedProducts[index];
                    return ProductsItemWidget(product: product);
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

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
