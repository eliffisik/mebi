import 'package:flutter/material.dart';
import '../RoundedButton.dart';
import './FeedScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;

  void _loginUser(BuildContext context) {
    // Perform login logic here

    // Assume login is successful
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FeedScreen(currentUserId:_email ),
      ),
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