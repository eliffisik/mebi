import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../RoundedButton.dart';
import './FeedScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;

  void _loginUser(BuildContext context) async {
    try {
      final url = Uri.parse('https://localhost:9001/api/Account/authenticate');
      final response = await http.post(
        url,
        body: json.encode({
          'email': _email,
          'password': _password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['data']['jwToken'];
        final id = responseData['data']['id'];
        final userName = responseData['data']['userName'];
        final email = responseData['data']['email'];

        // Perform login logic here

        // Assume login is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FeedScreen(currentUserId: id.toString()),
          ),
        );
      } else {
        throw Exception('Authentication failed');
      }
    } catch (error) {
      print(error);
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
          'Log in',
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
                  hintText: 'Enter Your email',
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Your password',
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(
                height: 40,
              ),
              RoundedButton(
                btnText: 'LOG IN',
                onBtnPressed: () {
                  _loginUser(context); // Call the login method
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
