import 'package:flutter/material.dart';

class CustomDrawerWidget extends StatelessWidget {
  final List<Map<String, dynamic>> pages;
  final int selectedPageIndex;
  final ValueChanged<int> onSelectPage;

  const CustomDrawerWidget({
    super.key,
    required this.pages,
    required this.selectedPageIndex,
    required this.onSelectPage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Text(
              'Mock Store',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ...pages.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> page = entry.value;

            return ListTile(
              leading: Icon(
                page['icon'],
                color: selectedPageIndex == index ? Colors.teal : Colors.grey,
              ),
              title: Text(
                page['title'],
                style: TextStyle(
                  color:
                      selectedPageIndex == index ? Colors.teal : Colors.black,
                  fontWeight: selectedPageIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              selected: selectedPageIndex == index,
              onTap: () => onSelectPage(index),
            );
          }),
        ],
      ),
    );
  }
}
