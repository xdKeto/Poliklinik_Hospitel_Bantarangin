import 'package:flutter/material.dart';

class AppStyles {
  static Color primaryColor = const Color(0xff45496A);
  static Color secondaryColor = const Color(0xff9AC5E5);
  static Color accentColor = const Color(0xffF6C445);
  static Color backgroundColor = const Color(0xffF4F4F4);
  static Color textColor = const Color(0xff171717);
  static Color redColor = const Color(0xffD31638);
  static Color greenColor = const Color(0xff59FC3C);
  static Color greyColor = const Color(0xffE3E3E3);
  static Color greyColor2 = const Color(0xffA9A9A9);
  static Color inputBox = const Color(0xffF6F6F6);

  static TextStyle normalText = TextStyle(
    fontFamily: 'Inter',
  );

  static TextStyle headingText = TextStyle(fontFamily: 'Inter', fontSize: 24);
  static TextStyle subheadingText =
      TextStyle(fontFamily: 'Inter', fontSize: 20);
  static TextStyle loginHeadText =
      TextStyle(fontFamily: 'Montserrat', fontSize: 24);
  static TextStyle contentText = TextStyle(fontFamily: 'Inter', fontSize: 14);
  static TextStyle sidebarText = TextStyle(fontFamily: 'Inter', fontSize: 16);
  static TextStyle tambahanText = TextStyle(fontFamily: 'Inter', fontSize: 18);
  static TextStyle titleText = TextStyle(fontFamily: 'Inter', fontSize: 30);

  static InputDecoration formBox = InputDecoration(
    filled: true,
    fillColor: AppStyles.inputBox,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppStyles.greyColor2),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  static BoxDecoration buttonBox(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    );
  }
}
