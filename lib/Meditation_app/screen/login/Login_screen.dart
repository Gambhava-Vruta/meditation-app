// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_project/Meditation_app/common/color_extension.dart';
// import 'package:flutter_project/Meditation_app/common_widget/round_button.dart';
// import 'package:flutter_project/Meditation_app/common_widget/round_Text_filed.dart';
//
// import '../home/welcome_screen.dart';
// import 'Sign_up_screen.dart';
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: context.height,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Image.asset(
//                     "assets/logo/meditation_logo/login_top.png",
//                     width: double.maxFinite,
//                     fit: BoxFit.fitWidth,
//                   ),
//                   Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 context.pop();
//                               },
//                               child: Image.asset(
//                                 "assets/logo/meditation_logo/back.png",
//                                 width: 55,
//                                 height: 55,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 25,
//                       ),
//                       Text(
//                         "Welcome Back!",
//                         style: TextStyle(
//                           color: TColor.primaryText,
//                           fontSize: 28,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 25,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: MaterialButton(
//                           onPressed: () {},
//                           minWidth: double.maxFinite,
//                           elevation: 0,
//                           color: const Color(0xff8E97FD),
//                           height: 60,
//                           shape: RoundedRectangleBorder(
//                               side: BorderSide.none,
//                               borderRadius: BorderRadius.circular(30)),
//                           child: Row(
//                             children: [
//                               const SizedBox(
//                                 width: 15,
//                               ),
//                               Image.asset(
//                                 'assets/logo/meditation_logo/fb.png',
//                                 width: 25,
//                                 height: 25,
//                               ),
//                               const Expanded(
//                                 child: Text(
//                                   "CONTINUE WITH FACEBOOK",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 40,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 25,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: MaterialButton(
//                           onPressed: () {},
//                           minWidth: double.maxFinite,
//                           elevation: 0,
//                           color: Colors.white,
//                           height: 60,
//                           shape: RoundedRectangleBorder(
//                               side:
//                               BorderSide(color: TColor.tertinary, width: 1),
//                               borderRadius: BorderRadius.circular(30)),
//                           child: Row(
//                             children: [
//                               const SizedBox(
//                                 width: 15,
//                               ),
//                               Image.asset(
//                                 'assets/logo/meditation_logo/google.png',
//                                 width: 25,
//                                 height: 25,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   "CONTINUE WITH GOOGLE",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: TColor.primaryText,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 40,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 35,
//               ),
//               Text(
//                 "OR LOG IN WITH EMAIL",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: TColor.secondaryText,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700),
//               ),
//               const SizedBox(
//                 height: 35,
//               ),
//               RoundTextFiled(hintText: "Email address"),
//               const SizedBox(
//                 height: 20,
//               ),
//               RoundTextFiled(
//                 hintText: "Password",
//                 obscureText: true,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               RoundButton(title: "LOG IN", onPressed: () {
//                 context.push( const WelcomeScreen());
//
//               }),
//               TextButton(
//                 onPressed: () {
//
//                 },
//                 child: Text(
//                   "Forgot Password?",
//                   style: TextStyle(
//                     color: TColor.primaryText,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//
//               const Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "CREATE A NEW ACCOUNT?",
//                     style: TextStyle(
//                       color: TColor.secondaryText,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       context.push(const SignUpScreen());
//                     },
//                     child: Text(
//                       "Sign up",
//                       style: TextStyle(
//                         color: TColor.primary,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               const Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Meditation_app/common/color_extension.dart';
import 'package:flutter_project/Meditation_app/common_widget/round_button.dart';
import 'package:flutter_project/Meditation_app/common_widget/round_Text_filed.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../home/welcome_screen.dart';
import 'Sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please fill in all fields.");
      return;
    }

    try {
      final url = Uri.parse("https://66ed09c0380821644cdb1124.mockapi.io/users"); // Replace with your MockAPI URL

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List users = json.decode(response.body);

        final user = users.firstWhere(
              (u) => u['email'] == email && u['password'] == password,
          orElse: () => null,
        );

        if (user != null) {
          _showMessage("Login successful");
          context.push(const WelcomeScreen());
        } else {
          _showMessage("Invalid email or password.");
        }
      } else {
        _showMessage("Server error. Please try again.");
      }
    } catch (e) {
      _showMessage("Error connecting to server.");
    }
  }


  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    "assets/logo/meditation_logo/login_top.png",
                    width: double.maxFinite,
                    fit: BoxFit.fitWidth,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: Image.asset(
                                "assets/logo/meditation_logo/back.png",
                                width: 55,
                                height: 55,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: double.maxFinite,
                          elevation: 0,
                          color: const Color(0xff8E97FD),
                          height: 60,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              Image.asset(
                                'assets/logo/meditation_logo/fb.png',
                                width: 25,
                                height: 25,
                              ),
                              const Expanded(
                                child: Text(
                                  "CONTINUE WITH FACEBOOK",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: double.maxFinite,
                          elevation: 0,
                          color: Colors.white,
                          height: 60,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: TColor.tertinary, width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              Image.asset(
                                'assets/logo/meditation_logo/google.png',
                                width: 25,
                                height: 25,
                              ),
                              Expanded(
                                child: Text(
                                  "CONTINUE WITH GOOGLE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Text(
                "OR LOG IN WITH EMAIL",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 35),
              RoundTextFiled(
                hintText: "Email address",
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              RoundTextFiled(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              RoundButton(title: "LOG IN", onPressed: _login),
              TextButton(
                onPressed: () {
                  context.push( const WelcomeScreen());

                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CREATE A NEW ACCOUNT?",
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(const SignUpScreen());
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: TColor.primary,
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
        ),
      ),
    );
  }
}
