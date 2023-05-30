import 'package:flutter/material.dart';
import './HomeScreen.dart';
import './SearchScreen.dart';
import './ProfileScreen.dart';
import './FavoriteScreen.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;

  const FeedScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;

  List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Bu satırı ekleyin
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 129, 82, 169),
        unselectedItemColor: Color.fromARGB(255, 129, 82, 169),
      ),
    );
  }
}
