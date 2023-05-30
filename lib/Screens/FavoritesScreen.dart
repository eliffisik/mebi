import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
          actions: [
         
          PopupMenuButton<String>(
            color: Color.fromARGB(255, 238, 218, 224),
            onSelected: (String value) {
              // Seçilen değeri kullanmak için gerekli işlemleri burada yapabilirsiniz
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
             
                PopupMenuItem<String>(
                  value: 'Settings',
                  child: Text('Settings'),
                  
                ),
                PopupMenuItem<String>(
                  value: 'Log Out',
                  child: Text('Log Out'),
                ),
              
              ];
            },
          ),
        ],
          backgroundColor:Color.fromARGB(255, 129, 82, 169),
      ),
      
      body: ListView(
        children: [
          _buildMessageCard('John Doe', 'This is my first message!'),
          _buildMessageCard('Jane Smith', 'Hello, Mebi!'),
          _buildMessageCard('Alice', 'Excited to be here!'),
          _buildMessageCard('Mark Johnson', 'Happy to join Mebi!'),
          _buildMessageCard('Sarah Thompson', 'Mebiing for the first time!'),
          _buildMessageCard('Michael Brown', 'Hello, world of Mebi!'),
          _buildMessageCard('Emily Wilson', 'Ready to share my thoughts.'),
          _buildMessageCard('David Lee', 'Socializing my way through life.'),
          _buildMessageCard('Sophia Roberts', 'Excited to connect with everyone!'),
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
  
