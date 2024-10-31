import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/product_detail/widgets/delete_confirmation_dialog.widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductsModel product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                final updatedProduct = (state as ProductsLoaded)
                    .products
                    ?.firstWhere((p) => p.id == product.id);

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
                  builder: (context) =>
                      DeleteConfirmationDialogWidget(id: product.id!),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Category
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),

                  // Ratings
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 15,
                      ),
                      const Gap(2),
                      Text(
                        '${product.rating?.rate.toString()} Ratings',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),

                  // Reviews
                  Row(
                    children: [
                      const Icon(
                        Icons.reviews_outlined,
                        size: 15,
                      ),
                      const Gap(2),
                      Text(
                        '${product.rating?.count.toString()} Reviews',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(10),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(5),
              Text(
                '\$${product.price.toString()}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              const Text(
                'Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(5),
              Text(product.description),
            ],
          ),
        ),
      ),
    );
  }
}
