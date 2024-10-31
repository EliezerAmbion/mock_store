import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';

class SortDialogWidget extends StatelessWidget {
  const SortDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 20,
            ),
            child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                final currentSorting =
                    context.read<ProductsBloc>().currentSorting;

                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    ),
                    const Text(
                      'Sort By:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    RadioListTile(
                      title: const Text('Ascending'),
                      value: Sorting.ascending,
                      groupValue: currentSorting,
                      onChanged: (val) {
                        context
                            .read<ProductsBloc>()
                            .add(const SortProductsByTitle(true));
                      },
                    ),
                    RadioListTile(
                      title: const Text('Descending'),
                      value: Sorting.descending,
                      groupValue: currentSorting,
                      onChanged: (val) {
                        context
                            .read<ProductsBloc>()
                            .add(const SortProductsByTitle(false));
                      },
                    ),
                    RadioListTile(
                      title: const Text('Price: (Low to High)'),
                      value: Sorting.lowToHigh,
                      groupValue: currentSorting,
                      onChanged: (val) {
                        context
                            .read<ProductsBloc>()
                            .add(const SortProductsByPrice(true));
                      },
                    ),
                    RadioListTile(
                      title: const Text('Price: (High to Low)'),
                      value: Sorting.highToLow,
                      groupValue: currentSorting,
                      onChanged: (val) {
                        context
                            .read<ProductsBloc>()
                            .add(const SortProductsByPrice(false));
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
