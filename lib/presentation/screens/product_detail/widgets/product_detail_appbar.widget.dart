import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/product_detail/widgets/delete_confirmation_dialog.widget.dart';

class ProductDetailAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final int id;

  const ProductDetailAppBarWidget({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        size: 30,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              final updatedProduct = (state as ProductsLoaded)
                  .products
                  ?.firstWhere((p) => p.id == id);

              return GestureDetector(
                onTap: () {
                  context
                      .read<ProductsBloc>()
                      .add(WishlistProduct(updatedProduct));
                },
                child: Icon(
                  updatedProduct!.isWishListed
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: updatedProduct.isWishListed ? Colors.red : null,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DeleteConfirmationDialogWidget(id: id),
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
