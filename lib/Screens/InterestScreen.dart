import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Interest {
  String description;
  String createdTime;

  Interest({
    required this.description,
    required this.createdTime,
  });

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
      description: json['description'] ?? '',
      createdTime: json['createdTime'] ?? '',
    );
  }
}

class InterestScreen extends StatefulWidget {
  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<Interest> interests = [];
  TextEditingController _interestNameController = TextEditingController();

  Future<void> fetchInterests(String interestName) async {
    final apiUrl = 'https://clean-architecture.azurewebsites.net/api/Post/interest/$interestName';

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        "accept": "*/*",
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] is List<dynamic>) {
          setState(() {
            interests = (responseData['data'] as List<dynamic>).map((item) => Interest.fromJson(item)).toList();
          });
        } else {
          print('Expected a list of interests. Response data: $responseData');
        }
      } else {
        print('Something went wrong. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while fetching interests: $e');
    }
  }

  @override
  void dispose() {
    _interestNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 82, 169),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Interests',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search a topic',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _interestNameController,
              decoration: InputDecoration(
                labelText: 'Enter Interest Name',
              ),
            ),
           SizedBox(
  height: 50,
  child: Align(
    alignment: Alignment.center,
    child: ElevatedButton(
                onPressed: () {
                  String interestName = _interestNameController.text;
                  fetchInterests(interestName);
                  
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 129, 82, 169),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
    ),
                ),
              ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(interests[index].description),
                    subtitle: Text(interests[index].createdTime),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
