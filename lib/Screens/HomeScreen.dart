import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> _likedStatus = [false, false, false, false, false, false, false];

  List<String> senders = [
    'Elif Isik',
    'Burcu Acan',
    'Mustafa Yencilek',
    'Bob John',
    'Emma H',
    'Michael Brown',
    'David Wilson'
  ];
  List<String> messages = [
    'This is my first message!',
    'Hello, how are you?',
    'Just wanted to say hi!',
    'What are your plans for today?',
    'Have a great day!',
    'Are you available for a meeting tomorrow?',
    'I hope you had a nice weekend.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromARGB(255, 129, 82, 169),
      ),
      body: ListView.builder(
        itemCount: senders.length,
        itemBuilder: (context, index) {
          return _buildMessageCard(senders[index], messages[index], index);
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
            color: _likedStatus[index]
                ? Color.fromARGB(255, 164, 37, 189)
                : null,
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
