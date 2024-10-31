import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar(
      {required String text, required BuildContext context, super.key})
      : super(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            left: 10,
            right: 10,
          ),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          content: Center(
            child: Text(text),
          ),
        );
}
