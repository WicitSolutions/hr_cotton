import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPStorage {
  static bool isLoggedIn = false;

  static void spIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');
    if (firstTime != null && !firstTime) {
      await prefs.setBool("isLoggedIn", false);
    } else {
      isLoggedIn = await prefs.getBool("isLoggedIn") ?? false;
    }
    printIsLoggedIn("SPStorage Class");
  }

  static void setIsLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", isLoggedIn);
    printIsLoggedIn("Set SPStorage Class");
  }

  static void printIsLoggedIn(String pageName) {
    if (kDebugMode) {
      print("isLoggedIn [$isLoggedIn] from $pageName");
    }
  }
}