import 'package:flutter/material.dart';
import './HomeScreen.dart';
import './AllPostScreen.dart';
import './ProfileScreen.dart';
import './InterestScreen.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;
  final String token;
  final String userName;
   final String firstName;
    final String lastName;
    final String email;

  FeedScreen({
    required this.currentUserId,
    required this.token,
    required this.userName,
     required this.firstName,
      required this.lastName, 
      required this.email,

  });

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;

  List<Widget> _screens = [ ];
    @override
  void initState() {
    super.initState();

    _screens = [
      HomeScreen(),
      InterestScreen(),
      AllPostsScreen(),
      ProfileScreen(
        currentUserId: widget.currentUserId,
  userName: widget.userName,
      token:widget.token,
      firstName: widget.firstName,
      lastName: widget.lastName,
      email: widget.email,

      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, 
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
            icon: Icon(Icons.post_add),
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