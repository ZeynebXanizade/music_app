import 'package:flutter/material.dart';
import 'package:music_app/src/screens/favorite_page.dart';
import 'package:music_app/src/screens/home_page.dart';
import 'package:music_app/src/screens/profile_page.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _children = [
    HomePage(),
    FavoritePage(),
    ProfilePage(),
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _children[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Theme.of(context).highlightColor,
          splashColor: Theme.of(context).splashColor,
        ),
        child: BottomNavigationBar(
          onTap: _onTapItem,
          currentIndex: _selectedIndex,
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon('assets/icons/home.png', _selectedIndex == 0),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(
                'assets/icons/favorite.png',
                _selectedIndex == 1,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon('assets/icons/profile.png', _selectedIndex == 2),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String assetPath, bool isSelected) {
    return Image.asset(
      assetPath,
      width: 25,
      height: 25,
      color:
          isSelected
              ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
    );
  }
}
