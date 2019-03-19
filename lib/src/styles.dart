import 'package:flutter/material.dart';

class TurfColors {
  static Color red = Color(0xffff4c5d);
  static Color bgColor = Color(0xffcad8e4);
  static Color blue =Color(0xff214489);
  static Color black =  Color(0xff0a1525);
  static Color white = Colors.white;
}

class HeaderStyles{
  static TextStyle dateTimePicker = TextStyle(
    color: TurfColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 16.0
  );

  static TextStyle buttonText =TextStyle(
    color: TurfColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 17.0
  );
}
