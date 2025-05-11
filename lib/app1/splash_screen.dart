import 'dart:async';
import 'package:flutter/material.dart';
import 'dashboard.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashbord()), // Change if necessary
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/image/splash.jpg',
          fit: BoxFit.cover,  // This makes the image fill the entire screen
          width: double.infinity,  // Makes sure it stretches to full width
          height: double.infinity,  // Makes sure it stretches to full height
        ),
      ),
    );
  }
}
