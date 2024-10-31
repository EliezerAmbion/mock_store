import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({required String text, super.key})
      : super(
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          content: Center(
            child: Text(text),
          ),
        );
}
