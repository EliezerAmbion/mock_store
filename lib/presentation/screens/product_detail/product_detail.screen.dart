import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/presentation/screens/product_detail/widgets/product_detail_appbar.widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductsModel product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductDetailAppBarWidget(id: product.id!),
      body: LayoutBuilder(builder: (context, constraints) {
        double titleSize;
        double categorySize;
        double detailsSize;
        double descriptionSize;
        BoxFit boxFit;
        MainAxisAlignment adaptiveMainAxisAlignment;
        CrossAxisAlignment adaptiveCrossAxisAlignment;

        if (constraints.maxWidth < 700) {
          titleSize = 16;
          categorySize = 13;
          detailsSize = 14;
          descriptionSize = 14;
          boxFit = BoxFit.cover;
          adaptiveMainAxisAlignment = MainAxisAlignment.spaceBetween;
          adaptiveCrossAxisAlignment = CrossAxisAlignment.start;
        } else if (constraints.maxWidth < 900) {
          titleSize = 20;
          categorySize = 18;
          detailsSize = 18;
          descriptionSize = 18;
          boxFit = BoxFit.cover;
          adaptiveMainAxisAlignment = MainAxisAlignment.spaceAround;
          adaptiveCrossAxisAlignment = CrossAxisAlignment.start;
        } else {
          titleSize = 28;
          categorySize = 26;
          detailsSize = 26;
          descriptionSize = 20;
          boxFit = BoxFit.contain;
          adaptiveMainAxisAlignment = MainAxisAlignment.spaceEvenly;
          adaptiveCrossAxisAlignment = CrossAxisAlignment.center;
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: adaptiveCrossAxisAlignment,
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.image,
                      fit: boxFit,
                    ),
                  ),
                ),
                const Gap(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: adaptiveMainAxisAlignment,
                  children: [
                    // Category
                    Text(
                      product.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: categorySize,
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
                          style: TextStyle(
                            fontSize: categorySize,
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
                          style: TextStyle(
                            fontSize: categorySize,
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
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(5),
                Text(
                  '\$${product.price.toString()}',
                  style: TextStyle(
                    fontSize: titleSize,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontSize: detailsSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.description,
                    style: TextStyle(
                      fontSize: descriptionSize,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
