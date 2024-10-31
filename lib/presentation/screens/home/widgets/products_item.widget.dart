import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/product_detail/product_detail.screen.dart';

class ProductsItemWidget extends StatelessWidget {
  final ProductsModel product;

  const ProductsItemWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    const double rad = 12;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return ProductDetailScreen(product: product);
            },
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rad),
        ),
        child: GridTile(
          header: Align(
            alignment: Alignment.topRight,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(rad),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                color: Colors.black54,
                child: Text(
                  '\$${product.price.toString()}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
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
              leading: GestureDetector(
                onTap: () {
                  context.read<ProductsBloc>().add(WishlistProduct(product));
                },
                child: Icon(
                  product.isWishListed ? Icons.favorite : Icons.favorite_border,
                  color: product.isWishListed ? Colors.red : null,
                ),
              ),
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
