import 'package:flutter/material.dart';

class ProductsItemWidget extends StatelessWidget {
  final String image;
  final String title;

  const ProductsItemWidget({
    required this.image,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black54,
        leading: const Icon(Icons.favorite_border),
      ),
      child: FadeInImage(
        placeholder: const AssetImage('assets/images/product-placeholder.png'),
        image: NetworkImage(image),
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/product-placeholder.png',
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
