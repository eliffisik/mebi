import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../RoundedButton.dart';
import 'WelcomeScreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String _firstName;
  late String _lastName;
  late String _description;
  late String _email;
  late String _userName;
  late String _password;
  late String _confirmPassword;

  void openWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url),
      ),
    ).then((value) {
      navigateToWelcomeScreen();
    });
  }

  Future<void> registerUser() async {
    String apiUrl = 'https://clean-architecture.azurewebsites.net/api/Account/register';
    print(apiUrl);

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "content-type": "application/json",
          "accept": "*/*",
        },
        body: jsonEncode({
          'firstName': _firstName,
          'lastName': _lastName,
          "description": _description,
          'email': _email,
          'userName': _userName,
          'password': _password,
          'confirmPassword': _confirmPassword,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var path = response.body.substring(135);
        print(response.body);
        String confirmEmailUrl = 'http://localhost:57561/api/account/confirm-email/?userId=4722365b-a8da-4c05-a9f9-241aafd62041&code=Q2ZESjhISWFXa0ZIdjZwSXJrSWtZQVZVcWtPV0pROXo1bXZQcGpRemtOTzMyaGI3TGNMV3BpbFNEN1MvcWw0ZlJmODJLME0vNjRJZHlHTERPMTJQZ0JYaEtnRStCZCt4VUVqTitqTVlNcHdqTkN4RTFWSGozVUd4ZlBOOVVaM0VTUnRHYVRSQWp3UVNVRHJCNUxnVmFuMXAvVXBZbzhlK28yWmVMMnpqNHFsUCtsenlUTDM4cFBXZUhFQjFDRkpKb29LUEpxOWh1K1dLeml6NkN6ZjVqeFJpRXFtZzVCaWpsd3g2ekFjVHhtVFBzeUpRUWlWRWFnOGNtNnNvQ3RPWEhXcHNhQT09';
        openWebView(confirmEmailUrl);

        // Başarılı kayıt durumunda yapılması gereken işlemler
        // Return the response object
      } else {
        print('Registration failed: ${response.body}');

        // Kayıt başarısız olduğunda yapılması gereken işlemler
        // Return null when registration fails
      }
    } catch (e) {
      print('Error during registration: $e');
      // Kayıt işlemi sırasında bir hata oluştuğunda yapılması gereken işlemler
      // Return null when an error occurs during registration
    }
  }

  void navigateToWelcomeScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
      (route) => false,
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
                    _firstName = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Surname',
                ),
                onChanged: (value) {
                  setState(() {
                    _lastName = value;
                  });
                },
              ),
                SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
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
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
                onChanged: (value) {
                  setState(() {
                    _userName = value;
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
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                ),
                onChanged: (value) {
                  setState(() {
                    _confirmPassword = value;
                  });
                },
              ),
              SizedBox(
                height: 50,
              ),
              RoundedButton(
                btnText: 'Create Account',
                onBtnPressed: () {
                  registerUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? _webViewController;

  void navigateToWelcomeScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // WebView AppBar özellikleri
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStop: (controller, url) {
          if (url == widget.url) {
            navigateToWelcomeScreen();
          }
        },
      ),
    );
  }
}
