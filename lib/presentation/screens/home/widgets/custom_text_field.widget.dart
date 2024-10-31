import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool isMobile;

  const CustomTextFieldWidget({
    required this.labelText,
    required this.controller,
    required this.validator,
    required this.isMobile,
    this.textInputType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder customOutlineInputBorder({
      required Color color,
      required double width,
    }) {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: width,
        ),
      );
    }

    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        isDense: isMobile,
        contentPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 18,
          vertical: isMobile ? 10 : 18,
        ),

        // border unfocused
        enabledBorder: customOutlineInputBorder(
          color: Colors.grey,
          width: 1,
        ),

        // border focused
        focusedBorder: customOutlineInputBorder(
          color: Colors.teal,
          width: 2,
        ),

        // error border color
        errorBorder: customOutlineInputBorder(
          color: Theme.of(context).colorScheme.error,
          width: 1,
        ),

        // focused error border color
        focusedErrorBorder: customOutlineInputBorder(
          color: Theme.of(context).colorScheme.error,
          width: 2,
        ),

        errorStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
