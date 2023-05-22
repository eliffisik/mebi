import 'package:flutter/material.dart';

import './HomeScreen.dart';
import './SearchScreen.dart';
import './ProfileScreen.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;

  const FeedScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;

  List<Widget> _screens = [
    HomeScreen(), // Pass currentUserId here
    SearchScreen(),
    ProfileScreen(),
  ];
  
  static get currentUserId => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Color.fromARGB(255, 129, 82, 169),
      ),
    );
  }
}
