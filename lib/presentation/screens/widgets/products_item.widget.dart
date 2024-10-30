import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/utils/routes.dart';

class ProductsItemWidget extends StatelessWidget {
  final ProductsModel product;

  const ProductsItemWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    const double rad = 12;

    return GestureDetector(
      onTap: () => context
          .go(Routes.productDetails.replaceAll(':id', product.id.toString())),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rad),
        ),
        child: GridTile(
          footer: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(rad),
              bottomRight: Radius.circular(rad),
            ),
            child: GridTileBar(
              title: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.black54,
              leading: const Icon(Icons.favorite_border),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(rad),
            child: FadeInImage(
              placeholder:
                  const AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.image),
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/product-placeholder.png',
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
