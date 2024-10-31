import 'package:flutter/material.dart';
import 'package:mock_store/presentation/screens/home/home.screen.dart';
import 'package:mock_store/presentation/screens/tabs/widgets/appbar_with_search.widget.dart';
import 'package:mock_store/presentation/screens/tabs/widgets/custom_bottom_navbar.widget.dart';
import 'package:mock_store/presentation/screens/tabs/widgets/custom_drawer.widget.dart';
import 'package:mock_store/presentation/screens/tabs/widgets/simple_appbar.widget.dart';
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
        'icon': Icons.home,
      },
      {
        'page': const WishListScreen(),
        'title': 'WishList',
        'icon': Icons.favorite,
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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 700;

    return Scaffold(
      appBar: _selectedPageIndex == 0
          ? AppBarWithSearchWidget(isMobile: isMobile)
          : const SimpleAppBarWidget(),
      drawer: isMobile
          ? null
          : CustomDrawerWidget(
              pages: _pages,
              selectedPageIndex: _selectedPageIndex,
              onSelectPage: _selectPage,
            ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: isMobile
          ? CustomBottomNavbarWidget(
              selectedPageIndex: _selectedPageIndex,
              onSelectPage: _selectPage,
            )
          : null,
    );
  }
}
