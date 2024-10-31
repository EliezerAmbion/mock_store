import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar(
      {required String text, required BuildContext context, super.key})
      : super(
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          content: Center(
            child: Text(text),
          ),
        );
}
