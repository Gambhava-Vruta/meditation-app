// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:flutter_project/app4/buttomnavigation.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   double _opacity = 0.0; // Start with invisible logo
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Start fade-in animation after a short delay
//     Future.delayed(Duration(milliseconds: 500), () {
//       setState(() {
//         _opacity = 1.0; // Make logo fully visible
//       });
//     });
//
//     // Navigate to Dashboard after 3 seconds
//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => MainScreen()),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFFFFD3C4), // Soft Peach
//               Color(0xFFFF8B7B), // Coral Pink
//             ],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Animated Logo with Fade-In Effect
//               AnimatedOpacity(
//                 opacity: _opacity,
//                 duration: Duration(seconds: 2),
//                 child: Image.asset(
//                   'assets/logo/logo.jpg',
//                   width: 120,
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Welcome Message
//               Text(
//                 'Welcome to Matrimo',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   letterSpacing: 1.5,
//                   shadows: [
//                     Shadow(
//                       blurRadius: 6,
//                       color: Colors.black38,
//                       offset: Offset(2, 2),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_project/app4/loging_screen.dart'; // Import the login screen.
import 'package:flutter_project/app4/buttomnavigation.dart'; // Import your main screen after login.

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; // Start with invisible logo

  @override
  void initState() {
    super.initState();

    // Start fade-in animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0; // Make logo fully visible
      });
    });

    // Check login status and navigate accordingly after 3 seconds
    Timer(Duration(seconds: 3), _navigateBasedOnLoginStatus);
  }

  // Check if the user is logged in
  Future<void> _navigateBasedOnLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Navigate to the MainScreen if already logged in
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MainScreen()),
      );
    } else {
      // Otherwise, navigate to the LoginScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFD3C4), // Soft Peach
              Color(0xFFFF8B7B), // Coral Pink
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Logo with Fade-In Effect
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 2),
                child: Image.asset(
                  'assets/logo/logo.jpg',
                  width: 120,
                ),
              ),
              SizedBox(height: 20), // Space between logo and text

              // Welcome Message
              Text(
                'Welcome to Matrimo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black38,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
