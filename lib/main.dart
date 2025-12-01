import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/views/loginPage.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:bookshop/views/registerUser.dart';
import 'package:bookshop/views/accountView.dart';
import 'package:bookshop/views/adminView.dart';
import 'package:bookshop/views/cartView.dart';
import 'package:bookshop/views/dashboardView.dart';
import 'package:bookshop/views/descriptionPage.dart';
import 'package:bookshop/views/splashScreen.dart';

String currentUserID = '';

void main() async {
  BookDB().initializeDB();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruina Book Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade100),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LogInPage(),
        '/home': (context) => DashboardPage(),
        '/registerUser': (context) => RegisterUserPage(),
        '/admin': (context) => AdminPage(),
        '/account': (context) => AccountPage(),
        '/cart': (context) => CartPage(),
        '/description': (context) => DescriptionPage(),
        // add more routes as needed
      },
      home: LogInPage(),
    );
  }
}