import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText, username, password;
  bool obscureText = false;

  CustomTextField({Key? key, required this.hintText, required this.obscureText, required this.username, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: obscureText ? const Icon(Icons.key) : const Icon(Icons.person),
          filled: true,
          hintText: hintText,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF263238),
            ),
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}
