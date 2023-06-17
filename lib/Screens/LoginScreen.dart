import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../RoundedButton.dart';
import 'FeedScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;

  Future<void> loginUser() async {
    String apiUrl =
        'https://clean-architecture.azurewebsites.net/api/Account/authenticate';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "content-type": "application/json",
          "accept": "*/*",
        },
        body: jsonEncode({
          'email': _email,
          'password': _password,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var token = data['data']['jwToken']; // Get token from response
        var userId = data['data']['id']; // Get userId from response
        var userName = data['data']['userName']; // Get username from response
        var firstName = data['data']['firstName']; // Get first name from response
        var lastName = data['data']['lastName'];// Get last name from response
        var email = data['data']['email']; 
         var description = data['data']['description']; 
        print('login successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeedScreen(
              currentUserId: userId,
              token: token,
              userName: userName,
              firstName:firstName??'',
              lastName:lastName??'',
              email:email??'',
            
           
            ),
          ),
        );
      } else {
        print('Login failed: ${response.body}');
        // Actions to take when login fails
      }
    } catch (e) {
      print('Error during login: $e');
    // Actions to be taken when an error occurs during login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 82, 169),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
                  hintText: 'Email',
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(
                height: 50,
              ),
              RoundedButton(
                btnText: 'Login',
                onBtnPressed: () {
                  loginUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
