import 'package:flutter/material.dart';
import './PostScreen.dart';
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 82, 169),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Profile',
          
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          
        ),
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
      ),
       body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile_picture.png'),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'I love Flutter!',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
        
            Text(
              'Tweets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with your own number of tweets
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Tweet ${index + 1}'),
                    subtitle: Text('Posted on ${DateTime.now().toString().substring(0, 10)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),

 floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}



