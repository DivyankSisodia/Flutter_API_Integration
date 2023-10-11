import 'dart:convert';

import 'package:api_call/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Call'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            // numbering ke liye index use kiya hai
            // final user = users[index];
            // emails show krne ke liye email variable use kiya hai
            // final email = user['email'];
            // first name show krne liye
            // final name = user['name']['first'];
            // final imageURL = user['picture']['medium'];
            final user = users[index];
            final email = user.email;
            return ListTile(
              title: Text(email),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchUser();
        },
        child: const Icon(Icons.deblur),
      ),
    );
  }

  void fetchUser() async {
    final uri = Uri.parse('https://randomuser.me/api?results=50');
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json['results'] as List<dynamic>;
    final tranform = result.map((e) {
      return User(
        name: e['name']['first'],
        email: e['email'],
        picture: e['picture']['medium'],
        phone: e['phone'],
        nat: e['nat'],
      );
    }).toList();
    setState(() {
      users = tranform;
    });
    // ignore: avoid_print
    print('users callled');
  }
}
