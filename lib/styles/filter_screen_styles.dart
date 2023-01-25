import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class FilterScreenStyles {
  static const ButtonStyle forgotPasswordButtonStyle = ButtonStyle(
    splashFactory: NoSplash.splashFactory,
    backgroundColor: MaterialStatePropertyAll(Colors.transparent),
    padding: MaterialStatePropertyAll(EdgeInsets.zero),
    elevation: MaterialStatePropertyAll(0),
  );

  // signupButtonTextStyles
  static const TextStyle checkBoxTextStyles = TextStyle(
    fontSize: 17,
    fontFamily: "Poppins"
  );
}