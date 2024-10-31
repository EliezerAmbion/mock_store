import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mock_store/presentation/screens/home/home.screen.dart';
import 'package:mock_store/presentation/screens/wishlist/wishlist.screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': const HomeScreen(),
        'title': 'Home',
      },
      {
        'page': const WishListScreen(),
        'title': 'WishList',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: Container(
        color: Colors.teal,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: GNav(
          onTabChange: (index) {
            _selectPage(index);
          },
          selectedIndex: _selectedPageIndex,
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
              icon: _selectedPageIndex == 1
                  ? Icons.favorite
                  : Icons.favorite_border,
              text: 'WishList',
            ),
          ],
        ),
      ),
    );
  }
}
