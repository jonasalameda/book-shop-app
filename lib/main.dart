import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/views/loginpage.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:bookshop/views/dashboardView.dart';
import 'package:bookshop/views/registerUser.dart';

void main() async {
  BookDB().initializeDB();
  runApp(MyApp());
}

// void initializeDB() {
//   initializeDB();
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruina Book Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LogInPage(),
        '/home': (context) => DashboardPage(),
        '/registerUser': (context) => RegisterUserPage(),
        // add more routes as needed
      },
    );
  }
}