import 'package:flutter/material.dart';

class Error404Screen extends StatelessWidget {
  const Error404Screen({Key? key}) : super(key: key);

  final TextStyle textStyle = const TextStyle(
      fontSize: 22,
      fontFamily: 'poppins',
      color: Colors.black,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.developer_mode_rounded,
              size: 60,
            ),
            const SizedBox(height: 5),
            Text( "Under Development", style: textStyle),
          ],
        ),
      ),
    );
  }
}
