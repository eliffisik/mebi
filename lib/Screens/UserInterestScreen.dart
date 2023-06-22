import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserInterestScreen extends StatelessWidget {
  final int userId;
  String email;
  String userInterestName;

  UserInterestScreen({
    required this.userId,
    required this.email,
    required this.userInterestName,
  });

  Future<void> createUserInterest() async {
    final apiUrl = 'https://clean-architecture.azurewebsites.net/api/UserInterest/createUserInterest/$userInterestName';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
        },
        body: jsonEncode({
          'userId': userId,
          'email': email,
          'userInterestName': userInterestName,
        }),
      );

      if (response.statusCode == 200) {
        print('User interest created successfully');
      } else {
        print('Something went wrong. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while creating user interest: $e');
    }
  }

  Future<List> getUserInterests() async {
    final apiUrl = 'https://clean-architecture.azurewebsites.net/api/UserInterest/userInterests/$email';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> interestsData = jsonResponse['data'];
        final List userInterests = interestsData.map((interest) => interest['userInterestName']).toList();
        return userInterests;
      } else {
        print('Something went wrong. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while getting user interests: $e');
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 82, 169),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'User Interests',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your new interest',
                ),
                onChanged: (value) {
                 
                    userInterestName = value;
               
                },
              ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              createUserInterest();
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 129, 82, 169),
            ),
            child: Text('Create New Interest'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final userInterests = await getUserInterests();
              
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        'My Interests',
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: userInterests.map((interest) => Text(interest)).toList(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 129, 82, 169),
            ),
            child: Text('Get Your Interests'),
          ),
        ],
      ),
        ),
        ),
        );
    
  }
}
