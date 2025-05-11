import 'package:flutter/material.dart';
import 'package:flutter_project/Meditation_app/common/color_extension.dart';

class CircleButton extends StatelessWidget {
  final String title;
  final bool isselect;
  final VoidCallback onPressed;

  const CircleButton(
      {super.key,
      required this.title,
      required this.isselect,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: isselect ? TColor.primaryText : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: TColor.secondaryText, width: 1)),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                color: isselect ? Colors.white : TColor.secondaryText,
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}
