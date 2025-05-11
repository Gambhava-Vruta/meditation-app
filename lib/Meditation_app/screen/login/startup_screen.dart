// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_project/Meditation_app/common/color_extension.dart';
// import 'package:flutter_project/Meditation_app/common_widget/round_button.dart';
// import 'package:flutter_project/Meditation_app/screen/login/Login_screen.dart';
//
//
// import 'Sign_up_screen.dart';
//
// class StartupScreen extends StatefulWidget {
//   const StartupScreen({super.key});
//
//   @override
//   State<StartupScreen> createState() => _StartupScreenState();
// }
//
// class _StartupScreenState extends State<StartupScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(
//             "assets/logo/meditation_logo/starup_top.png",
//             width: double.maxFinite,
//             fit: BoxFit.fitWidth,
//           ),
//           const Spacer(),
//           Text("We are what we do",
//               style: TextStyle(
//                   color: TColor.secondaryText,
//                   fontSize: 30,
//                   fontWeight: FontWeight.w700)),
//           const SizedBox(
//             height: 15,
//           ),
//           Text("thousand of people are using silent moon for smalls meditation",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: TColor.secondaryText,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600)),
//           const Spacer(),
//           RoundButton(title: "Sign up", onPressed: () {
//             context.push(const SignUpScreen());
//           }),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Already have account?",
//                   style: TextStyle(
//                       color: TColor.secondaryText,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600)),
//               TextButton(
//                   onPressed: () {
//                     context.push(const LoginScreen());
//                   },
//                   child: Text("Login",
//                       style: TextStyle(
//                           color: TColor.secondaryText,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600)))
//             ],
//           ),
//           const Spacer(),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Meditation_app/common/color_extension.dart';
import 'package:flutter_project/Meditation_app/common_widget/round_button.dart';
import 'package:flutter_project/Meditation_app/screen/login/Login_screen.dart';
import 'Sign_up_screen.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo and header image at the top
          Image.asset(
            "assets/logo/meditation_logo/starup_top.png",
            width: double.maxFinite,
            fit: BoxFit.fitWidth,
          ),
          const Spacer(),

          // Title and description text
          Text(
            "We are what we do",
            style: TextStyle(
              color: TColor.secondaryText,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "Thousands of people are using Silent Moon for small meditations.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: TColor.secondaryText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),

          // Round Sign Up button
          RoundButton(
            title: "Sign up",
            onPressed: () {
              // Navigate to SignUpScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              );
            },
          ),

          // Row for "Already have account?" text and Login button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to LoginScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
