import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        backgroundColor: Color.fromARGB(255, 129, 82, 169),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
             
                labelText: 'Enter your message',
                
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              
              onPressed: () {
                String message = _messageController.text;
                // Burada gönderi oluşturma işlemleri yapılabilir
                // Örneğin, gönderiyi bir API'ye post etmek gibi
                print('Gönderilen mesaj: $message');
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
