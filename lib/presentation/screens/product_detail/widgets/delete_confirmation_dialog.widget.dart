import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';

class DeleteConfirmationDialogWidget extends StatelessWidget {
  final int id;

  const DeleteConfirmationDialogWidget({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Confirm Deletion',
        textAlign: TextAlign.center,
      ),
      content: const Text('Are you sure you want to delete this product?'),
      actions: [
        // Cancel
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),

        // Confirm Deletion
        TextButton(
          onPressed: () {
            context.read<ProductsBloc>().add(DeleteProduct(id));
            Navigator.of(context).pop();

            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     backgroundColor: Colors.teal,
            //     behavior: SnackBarBehavior.floating,
            //     content: Center(
            //       child: Text('Product deleted successfully'),
            //     ),
            //   ),
            // );

            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
