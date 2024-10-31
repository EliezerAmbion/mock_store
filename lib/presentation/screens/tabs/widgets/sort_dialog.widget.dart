import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';

class SortDialogWidget extends StatelessWidget {
  const SortDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> options = ['Options 1', 'Options 2'];
    String currentOption = options[0];

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 20,
            ),
            child: Column(
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
                  value: const Text(
                    'Options 1',
                  ),
                  groupValue: currentOption,
                  onChanged: (val) {
                    context
                        .read<ProductsBloc>()
                        .add(const SortProductsByTitle(true));
                  },
                ),
                RadioListTile(
                  title: const Text('Descending'),
                  value: const Text(
                    'Options 1',
                  ),
                  groupValue: currentOption,
                  onChanged: (val) {
                    context
                        .read<ProductsBloc>()
                        .add(const SortProductsByTitle(false));
                  },
                ),
                RadioListTile(
                  title: const Text('Price: (Low to High)'),
                  value: const Text(
                    'Options 1',
                  ),
                  groupValue: currentOption,
                  onChanged: (val) {
                    context
                        .read<ProductsBloc>()
                        .add(const SortProductsByPrice(true));
                  },
                ),
                RadioListTile(
                  title: const Text('Price: (High to Low)'),
                  value: const Text(
                    'Options 1',
                  ),
                  groupValue: currentOption,
                  onChanged: (val) {
                    context
                        .read<ProductsBloc>()
                        .add(const SortProductsByPrice(false));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
