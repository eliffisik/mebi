import 'package:flutter/material.dart';


import '../RoundedButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;

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
                  _email = value;
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
                  _password = value;
                },
              ),
              SizedBox(
                height: 40,
              ),
              RoundedButton(
                btnText: 'LOG IN',
                onBtnPressed: () {
                  // Perform login action
                  print('Email: $_email');
                  print('Password: $_password');
                  // Implement your login logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
