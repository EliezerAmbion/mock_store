import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mock_store/data/models/products/products.model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductsModel product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: GestureDetector(
              child: const Icon(Icons.favorite_border),
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
                        '${product.rating.rate.toString()} Ratings',
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
                        '${product.rating.count.toString()} Reviews',
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
