import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common.dart';
import 'setLocaleMaterialApp.dart';

String? currentUserID;

Future<void> main() async {
  await loadCurrentUser();
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(context);
  }
}