import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Text("This app manages users and their details.")),
      ),
    );
  }
}
