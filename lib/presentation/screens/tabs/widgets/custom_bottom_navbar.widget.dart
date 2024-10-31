import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavbarWidget extends StatelessWidget {
  final int selectedPageIndex;
  final ValueChanged<int> onSelectPage;

  const CustomBottomNavbarWidget({
    required this.selectedPageIndex,
    required this.onSelectPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GNav(
        onTabChange: (index) {
          onSelectPage(index);
        },
        selectedIndex: selectedPageIndex,
        backgroundColor: Colors.teal,
        color: Colors.black,
        activeColor: Colors.black,
        tabBackgroundColor: Colors.white,
        gap: 8,
        padding: const EdgeInsets.all(16),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabs: [
          const GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon:
                selectedPageIndex == 1 ? Icons.favorite : Icons.favorite_border,
            text: 'WishList',
          ),
        ],
      ),
    );
  }
}
