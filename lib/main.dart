import 'package:bookshop/env.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'common.dart';
import 'setLocaleMaterialApp.dart';

// String? currentUserID;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadCurrentUser();
  await dotenv.load(fileName: 'lib/.env');
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: Enviroment.apiKey,
      appId: Enviroment.appID,
      messagingSenderId: Enviroment.messagingSenderId,
      projectId: Enviroment.projectId,
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
