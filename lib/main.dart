import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_cotton/screens/filters_screen.dart';
import 'package:hr_cotton/screens/home_screen.dart';
import 'package:hr_cotton/screens/inventories_screen.dart';
import 'package:hr_cotton/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hr Cotton',
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginScreen(), // LoginScreen()
        '/home': (context) => const HomeScreen(),
        '/filters': (context) => const FilterPanel(),
        '/inventories': (context) => const InventoriesScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
