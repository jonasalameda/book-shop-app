import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common.dart';
import 'setLocaleMaterialApp.dart';

String? currentUserID;

void showAlert(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 10),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      action: SnackBarAction(
        // optional action button
        label: "Close",
        textColor: Colors.grey,
        onPressed: () {
          ScaffoldMessenger.of(context)
              .hideCurrentSnackBar(); //hide snack bar
        },
      ),
    ),
  );
}

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