import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> _likedStatus = [false, false, false, false, false]; // Beğeni durumunu tutan bir liste

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
      body: ListView.builder(
        itemCount: 5, // Değiştirilmesi gereken öğe sayısı
        itemBuilder: (context, index) {
          return _buildMessageCard('John Doe', 'This is my first message!', index);
        },
      ),
    );
  }

  Widget _buildMessageCard(String sender, String message, int index) {
    return Card(
      child: ListTile(
        title: Text(sender),
        subtitle: Text(message),
        trailing: IconButton(
          icon: Icon(
            _likedStatus[index] ? Icons.favorite : Icons.favorite_border,
            color: _likedStatus[index] ? Color.fromARGB(255, 164, 37, 189) : null,
          ),
          onPressed: () {
            setState(() {
              _likedStatus[index] = !_likedStatus[index]; 
            });
          },
        ),
      ),
    );
  }
}
