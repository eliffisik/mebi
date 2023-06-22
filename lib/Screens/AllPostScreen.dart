import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {
  String description;
  String createdTime;
  String firstName;
  String lastName;
  String userName;
   int userId;
  int tweetId;
  
  

  Post({
    required this.description,
    required this.createdTime,
    required this.firstName,
    required this.lastName,
     required this.userName,
      required this.userId,
    required this.tweetId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      description: json['description'] ?? '',
      createdTime: json['createdTime'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
        userName: json['userName'] ?? '',
         userId: json['userId'] ?? 0,
    tweetId: json['tweetId'] ?? 0,
    );
  }

  Future<void> comment({required int userId, required int tweetId}) async {
    const apiUrl = 'https://clean-architecture.azurewebsites.net/api/Comment/Post';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'description':description,
          'userId': userId,
          'userName': userName,
          'firstName': firstName,
          'lastName': lastName,
          'tweetId': tweetId,
        }),
      );

      if (response.statusCode == 200) {
        print('Comment posted successfully');
    
      } else {
        print('Failed to post comment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while posting comment: $e');
    }
  }
}

class AllPostsScreen extends StatefulWidget {
  @override
  _AllPostsScreenState createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  List<Post> posts = [];

  Future<void> fetchPosts() async {
    const apiUrl = 'https://clean-architecture.azurewebsites.net/api/Post?PageNumber=1&PageSize=100';

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        "accept": "*/*",
      });

      if (response.statusCode == 200) {
        print('Successful');
        final responseData = jsonDecode(response.body);
        if (responseData['data'] is List<dynamic>) {
          setState(() {
            posts = (responseData['data'] as List<dynamic>).map((item) => Post.fromJson({...item,
            'userId': item['userId'],
             'tweetId': item['tweetId'],
            })).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 82, 169),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'All Posts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${posts[index].firstName} ${posts[index].lastName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(posts[index].description),
                ],
              ),
              subtitle: Text(posts[index].createdTime),
              trailing: IconButton(
                icon: Icon(Icons.comment),
                color: Color.fromARGB(255, 129, 82, 169),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String commentText = '';

                      return AlertDialog(
                        title: Text('Add a comment'),
                        content: TextField(
                          onChanged: (value) {
                            commentText = value;
                          },
                          decoration: InputDecoration(hintText: 'Enter your comment'),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              posts[index].comment(
                        userId: posts[index].userId,
                          tweetId: posts[index].tweetId,


                              );
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 129, 82, 169),
                              ),
                            ),
                            child: Text('Post Comment'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
