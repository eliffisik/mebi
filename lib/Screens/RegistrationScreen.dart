
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../RoundedButton.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String _email;
  late String _password;
  late String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 82, 169),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Registration',
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
                  hintText: 'Name',
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              SizedBox(
                height: 30,
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
                height: 40,
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
                btnText: 'Create account',
                onBtnPressed: () {
                   createUser();
                  // Implement your logic for creating a user account here
                  // You can use the entered values (_name, _email, _password) to register the user
                },
              ),

              
            ],
            
          ),
        ),
      ),
      
    );
  }
  Future<void> createUser() async {
  final url = 'https://localhost:9001/api/Account/register'; // API URL'sini buraya ekleyin

  final response = await http.post(
    Uri.parse(url),
    body: json.encode({
      'name': _name,
      'email': _email,
      'password': _password,
    }),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
   print("kayıt başarılı");
  } else {
   print("kayıt başarısız");
  }
}
}
