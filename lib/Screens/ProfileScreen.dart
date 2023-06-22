import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './PostScreen.dart';
import './WelcomeScreen.dart';

class Post {
  String description;
  String createdTime;

  Post({
    required this.description,
    required this.createdTime,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      description: json['description'] ?? '',
      createdTime: json['createdTime'] ?? '',
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final String currentUserId;
  final String userName;
  final String token;
  final String firstName;
  final String lastName;
  final String email;
  final String description;

  ProfileScreen({
    required this.currentUserId,
    required this.userName,
    required this.token,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.description,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Post> posts = [];

  Future<void> fetchPosts() async {
    final apiUrl =
        'https://clean-architecture.azurewebsites.net/api/Post/sender/${widget.email}';

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        "accept": "*/*",
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] is List<dynamic>) {
          setState(() {
            posts = (responseData['data'] as List<dynamic>)
                .map((item) => Post.fromJson(item))
                .toList();
          });
        } else {
          print('Expected a list of posts. Response data: $responseData');
        }
      } else {
        print('Something went wrong. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while fetching posts: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }

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
              if (value == 'Log Out') {
                logout();
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
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
                      ' ${widget.firstName} ${widget.lastName}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' @${widget.userName}',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '  ${widget.description}',
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
              '   My Posts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(posts[index].description),
                    subtitle: Text(posts[index].createdTime),
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
              builder: (context) => PostScreen(
                userId: widget.currentUserId,
                userName: widget.userName,
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
              ),
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
