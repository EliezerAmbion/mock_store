import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mock_store/data/models/products/products.model.dart';
import 'package:mock_store/presentation/blocs/products/products_bloc.dart';
import 'package:mock_store/presentation/screens/home/widgets/custom_text_field.widget.dart';

class AddProductDialogWidget extends StatelessWidget {
  const AddProductDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageController = TextEditingController();
    final categoryController = TextEditingController();

    return Dialog(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Add a Product'),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldWidget(
                      labelText: 'Title',
                      controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty || value.length > 20) {
                          return 'Value can not be empty or more than 20 characters';
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CustomTextFieldWidget(
                      labelText: 'Price',
                      controller: priceController,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty || double.parse(value) < 0) {
                          return 'Price must be positive number';
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CustomTextFieldWidget(
                      labelText: 'Description',
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty || value.length > 20) {
                          return 'Description can not be empty or more than 20 characters';
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CustomTextFieldWidget(
                      labelText: 'Image URL',
                      controller: imageController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Image can not be empty.';
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CustomTextFieldWidget(
                      labelText: 'Category',
                      controller: categoryController,
                      validator: (value) {
                        if (value!.isEmpty || value.length > 20) {
                          return 'Value can not be empty or more than 20 characters';
                        }
                        return null;
                      },
                    ),
                    const Gap(10),

                    // Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          final bool isValid = formKey.currentState!.validate();
                          if (!isValid) return;

                          final newProduct = ProductsModel(
                            title: titleController.text,
                            price: double.parse(priceController.text),
                            description: descriptionController.text,
                            category: categoryController.text,
                            image: imageController.text,
                          );

                          context
                              .read<ProductsBloc>()
                              .add(AddProduct(newProduct));
                        },
                        child: const Text('Add'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
