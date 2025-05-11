import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class RoundTextFiled extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboard;
  final bool? obscureText;
  final Widget? right;
  final String hintText;
  const RoundTextFiled({super.key, this.controller, this.keyboard, this.obscureText, this.right, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: TColor.textBG,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        obscureText: obscureText ?? false,
        style: TextStyle(
          color: TColor.primaryText,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: InputBorder.none,
          hintText: hintText,
          suffixIcon:right,
          hintStyle:TextStyle(
            color: TColor.primaryText,
            fontSize: 16,
          )
        ),

      ),
    );
  }
}
