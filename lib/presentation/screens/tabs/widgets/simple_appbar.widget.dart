import 'package:flutter/material.dart';

class SimpleAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const SimpleAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Wishlist'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
