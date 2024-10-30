import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;

  const ProductDetailScreen({required this.id, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    print('>> (12): product_detail.screen <<\n==> product detail <==');
    context.read<ProductsBloc>().add(GetProductById(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    state.errorMessage.toString(),
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductDetailLoaded) {
            final product = state.product;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
