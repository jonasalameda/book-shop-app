import 'package:bookshop/controllers/DbController.dart';
import 'package:bookshop/views/adminCustomers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bookshop/views/loginpage.dart';
import 'package:bookshop/views/registerUser.dart';
import 'package:bookshop/views/accountView.dart';
import 'package:bookshop/views/adminView.dart';
import 'package:bookshop/views/cartView.dart';
import 'package:bookshop/views/dashboardView.dart';
import 'package:bookshop/views/descriptionPage.dart';
import 'package:bookshop/views/splashScreen.dart';
import 'package:bookshop/models/UserModel.dart';

String currentUserID = "0W9tQfd131ribtU2cw4P"; //default user
UserModel? currentUser = null;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBbuPvGLzeKv0pXmx00hlXySPxT7F8ZQcE",
      appId: "530607033314",
      messagingSenderId: "1:530607033314:android:f0812a8ac5623e81bd47bb",
      projectId: "book-shop-cdfd8",
    ),
  );
  // BookDB().initializeDB();
  runApp(MyApp());
}

Future<void> loadCurrentUser() async {
  if (currentUserID.isEmpty) return;
  currentUser = await getUserById(currentUserID);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruina Book Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown.shade400),
      ),
      routes: {
        '/login': (context) => LogInPage(),
        '/home': (context) => DashboardPage(),
        '/registerUser': (context) => RegisterUserPage(),
        '/admin': (context) => AdminPage(),
        '/account': (context) => AccountPage(),
        // '/cart': (context) => CartPage(userID: currentUserId),
        '/cart': (context) => CartPage(),
        '/description': (context) => DescriptionPage(),
        '/adminCustomers': (context) => AdminCustomersPage(),
        // add more routes as needed
      },
      home: SplashScreen(),
    );
  }
}
