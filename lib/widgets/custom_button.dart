import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function()? onPress; // Good

  const CustomButton({Key? key, required this.text, required this.color, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        color: color,
        onPressed: onPress,
        height: 45,
        elevation: 0,
        child: /*Text(
            text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        )*/TextButton.icon(
            onPressed: () {},
            icon: Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
            label: const Text("")
        ),
      ),
    );
  }
}
