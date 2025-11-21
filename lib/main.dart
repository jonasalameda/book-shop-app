import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/views/loginPage.dart';
import 'package:bookshop/views/registerUser.dart';
import 'package:bookshop/views/dashboardView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCjexEQCUZ3OhMj-VyXJcYTV7clWJclu6w",
      appId: "464024739524",
      messagingSenderId: "1:464024739524:android:7bd3f8116a399a5672f391",
      projectId: "library-of-ruina",
    ),
  );
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