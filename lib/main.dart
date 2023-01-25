import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hr_cotton/screens/customer_balance_filters_screen.dart';
import 'package:hr_cotton/screens/customer_balance_screen.dart';
import 'package:hr_cotton/screens/inventory_filters_screen.dart';
import 'package:hr_cotton/screens/home_screen.dart';
import 'package:hr_cotton/screens/inventories_screen.dart';
import 'package:hr_cotton/screens/login_screen.dart';
import 'package:hr_cotton/screens/po_list_filters_screen.dart';
import 'package:hr_cotton/screens/po_list_screen.dart';
import 'package:hr_cotton/screens/salesInvoiceFiltersScreen.dart';
import 'package:hr_cotton/screens/sales_invoices_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/storageSharedPrefrences.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    SPStorage.spIsLoggedIn();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Hr Cotton',
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      // initialRoute: SPStorage.isLoggedIn ? '/home' : '/loginScreen',
      routes: {
        '/': (context) => SPStorage.isLoggedIn ? const HomeScreen() : const LoginScreen(),
        '/loginScreen': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/inventoryFilters': (context) => const InventoryFiltersScreen(),
        '/inventories': (context) => const InventoriesScreen(),
        '/saleInvoices': (context) => const SaleInvoicesScreen(),
        '/saleInvoicesFilters': (context) => const SalesInvoiceFiltersScreen(),
        '/poListScreen': (context) => const PoListScreen(),
        '/poListFiltersScreen': (context) => const PoListFiltersScreen(),
        '/custBalanceScreen': (context) => const CustomerBalanceScreen(),
        '/custBalanceFiltersScreen': (context) => const CustBalanceFiltersScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
