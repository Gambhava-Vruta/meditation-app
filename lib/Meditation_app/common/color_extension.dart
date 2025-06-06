import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class TColor{
  static Color get primary=>const Color(0xff8E97FD);
  static Color get secondary=>const Color(0xff3F414E);
  static Color get tertinary=>const Color(0xffEBEAEc);
  static Color get sleep => const Color(0xff03174C);
  static Color get sleepText => const Color(0xffE6E7F2);

  static Color get primaryText=>const Color(0xff3F414E);
  static Color get primaryTextw=>const Color(0xffF6F1FB);
  static Color get secondaryText=>const Color(0xffA1A4B2);
  static Color get textBG=>const Color(0xffF2F3F7);

}extension Appcontext on BuildContext{
  Size get size=>MediaQuery.sizeOf(this);
  double get width=>size.width;
  double get height=>size.height;
  Future push(Widget widget)async {
    return Navigator.push(this,MaterialPageRoute(builder: (context)=>widget));
  }
  void pop() async{
    return Navigator.pop(this);
  }
}
extension HexColor on Color{
  static Color formHex(String hexString){
    final buffer=StringBuffer();
    if(hexString.length==6 || hexString.length==7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(),radix:16));
  }
}