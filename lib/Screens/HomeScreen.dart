import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
          backgroundColor:Color.fromARGB(255, 129, 82, 169),
      ),
      body: ListView(
        children: [
          _buildMessageCard('John Doe', 'This is my first tweet!'),
          _buildMessageCard('Jane Smith', 'Hello, Twitter!'),
          _buildMessageCard('Alice', 'Excited to be here!'),
        ],
      ),
    );
  }

  Widget _buildMessageCard(String username, String tweet) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:Color.fromARGB(255, 129, 82, 169),
          child: Text(
            username.substring(0, 1),
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(username),
        subtitle: Text(tweet),
      ),
    );
  }
}
