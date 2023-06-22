import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostScreen extends StatelessWidget {
  final String userId;
  final String userName;
  final String firstName;
  final String lastName;
  final String email;

  String? description;
  String? interestName;
  int? senderId;

  PostScreen({
    required this.userId,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Future<void> postTweet() async {
    const apiUrl = 'https://clean-architecture.azurewebsites.net/api/Post/Post';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "content-type": "application/json",
          "accept": "*/*",
        },
        body: jsonEncode({
          'description': description,
          'firstName': firstName,
          'lastName': lastName,
          'userName': userName,
          'interestName': interestName,
          'senderEmail': email,
        }),
      );

      if (response.statusCode == 200) {
        print('Post successful');
        // Tweet posted successfully
      } else {
        print('Something went wrong. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Tweet posting failed
      }
    } catch (e) {
      print('Error occurred while posting tweet: $e');
      // Error occurred while posting tweet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 82, 169),
        title: Text('Create Post'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome, $firstName!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Description',
                  ),
                  onChanged: (value) {
                    description = value;
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Interest Name',
                  ),
                  onChanged: (value) {
                    interestName = value;
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              postTweet();
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 129, 82, 169),
            ),
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}
