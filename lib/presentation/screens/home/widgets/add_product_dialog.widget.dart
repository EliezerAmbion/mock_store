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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 700;
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageController = TextEditingController();
    final categoryController = TextEditingController();

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        size: isMobile ? 20 : 25,
                      ),
                    ),
                  ),
                  Text(
                    'Add a Product',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: isMobile ? 18 : 22,
                    ),
                  ),
                  gapWidget(isMobile),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldWidget(
                        isMobile: isMobile,
                        labelText: 'Title',
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty || value.length > 20) {
                            return 'Value can not be empty or more than 20 characters';
                          }
                          return null;
                        },
                      ),
                      gapWidget(isMobile),
                      CustomTextFieldWidget(
                        isMobile: isMobile,
                        labelText: 'Price',
                        controller: priceController,
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Price cannot be empty';
                          }
                          final price = double.tryParse(value);
                          if (price == null || price < 0) {
                            return 'Price must be a positive number';
                          }
                          return null;
                        },
                      ),
                      gapWidget(isMobile),
                      CustomTextFieldWidget(
                        isMobile: isMobile,
                        labelText: 'Description',
                        controller: descriptionController,
                        validator: (value) {
                          if (value!.isEmpty || value.length > 20) {
                            return 'Description can not be empty or more than 20 characters';
                          }
                          return null;
                        },
                      ),
                      gapWidget(isMobile),
                      CustomTextFieldWidget(
                        isMobile: isMobile,
                        labelText: 'Image URL',
                        controller: imageController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Image can not be empty.';
                          }
                          return null;
                        },
                      ),
                      gapWidget(isMobile),
                      CustomTextFieldWidget(
                        isMobile: isMobile,
                        labelText: 'Category',
                        controller: categoryController,
                        validator: (value) {
                          if (value!.isEmpty || value.length > 20) {
                            return 'Value can not be empty or more than 20 characters';
                          }
                          return null;
                        },
                      ),
                      gapWidget(isMobile),

                      // Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 35 : 40,
                              vertical: isMobile ? 12 : 16,
                            ),
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            final bool isValid =
                                formKey.currentState!.validate();
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

                            Navigator.pop(context);
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontSize: isMobile ? 15 : 19,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget gapWidget(bool isMobile) {
    return Gap(isMobile ? 12 : 18);
  }
}
