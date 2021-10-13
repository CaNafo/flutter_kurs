import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/providers/home_provider.dart';
import 'package:movies_app/screens/favorites_screen.dart';
import 'package:movies_app/screens/home_screen.dart';
import 'package:movies_app/screens/search_screen.dart';
import 'package:movies_app/screens/settings_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const routeName = "tab_screen";
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  Map<int, dynamic> listOfScreens = {
    0: ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: const HomeScreen(),
    ),
    1: const SearchScreen(),
    2: const FavoritesScreen(),
    3: const SettingsScreen()
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          CircleAvatar(
            child: Icon(Icons.supervised_user_circle),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: listOfScreens.entries.elementAt(_selectedIndex).value,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(color: Colors.blue),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            activeIcon: CircleAvatar(
              child: Icon(Icons.home, color: Colors.white),
              backgroundColor: Colors.blue,
            ),
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            activeIcon: CircleAvatar(
              child: Icon(Icons.search, color: Colors.white),
              backgroundColor: Colors.blue,
            ),
            icon: Icon(Icons.search, color: Colors.blue),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            activeIcon: CircleAvatar(
              child: Icon(Icons.home, color: Colors.white),
              backgroundColor: Colors.blue,
            ),
            icon: Icon(Icons.favorite, color: Colors.blue),
            label: 'School',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            activeIcon: CircleAvatar(
              child: Icon(Icons.home, color: Colors.white),
              backgroundColor: Colors.blue,
            ),
            icon: Icon(Icons.settings, color: Colors.blue),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
