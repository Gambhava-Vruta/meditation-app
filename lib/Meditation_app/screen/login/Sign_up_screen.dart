// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_project/Meditation_app/common/color_extension.dart';
// import 'package:flutter_project/Meditation_app/common_widget/round_button.dart';
// import 'package:flutter_project/Meditation_app/common_widget/round_Text_filed.dart';
// import 'package:flutter_project/Meditation_app/screen/home/welcome_screen.dart';
//
// import '../home/choose_topic_screeen.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   bool isTrue = false;
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
//                         "Create new Account",
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
//                                   BorderSide(color: TColor.tertinary, width: 1),
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
//               RoundTextFiled(hintText: "User Name"),
//               const SizedBox(
//                 height: 20,
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
//                 height: 0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     Text(
//                       "i have read the text",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: TColor.secondaryText,
//                         fontSize: 14,
//                       ),
//                     ),
//                     Text(
//                       "Privacy Policy",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: TColor.primary,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const Spacer(),
//                     IconButton(
//                         onPressed: () {
//                           isTrue = !isTrue;
//                         },
//                         icon: Icon(isTrue
//                             ? Icons.check_box
//                             : Icons.check_box_outline_blank_rounded,color: isTrue?TColor.primary:TColor.secondaryText,))
//                   ],
//                 ),
//               ),
//               RoundButton(title: "Get started", onPressed: () {
//                 context.push(const WelcomeScreen());
//               }),
//               const Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_project/Meditation_app/screen/main_Tableview/main_tabview_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_project/Meditation_app/common/color_extension.dart';
import 'package:flutter_project/Meditation_app/common_widget/round_button.dart';
import 'package:flutter_project/Meditation_app/common_widget/round_Text_filed.dart';
import 'package:flutter_project/Meditation_app/screen/home/welcome_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isTrue = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signup() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty || !isTrue) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields and accept the Privacy Policy"),
        ),
      );
      return;
    }

    try {
      final url = Uri.parse("https://66ed09c0380821644cdb1124.mockapi.io/users");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup successful")),
        );
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        // );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainTabViewScreen()),
        );

      } else {
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(body["message"] ?? "Signup failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
                                Navigator.pop(context);
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
                        "Create new Account",
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
                              borderRadius: BorderRadius.circular(30)),
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
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 35),
              RoundTextFiled(
                hintText: "User Name",
                controller: _usernameController,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "I have read the text ",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                        color: TColor.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isTrue = !isTrue;
                        });
                      },
                      icon: Icon(
                        isTrue
                            ? Icons.check_box
                            : Icons.check_box_outline_blank_rounded,
                        color: isTrue
                            ? TColor.primary
                            : TColor.secondaryText,
                      ),
                    )
                  ],
                ),
              ),
              RoundButton(
                title: "Get started",
                onPressed: _signup,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
