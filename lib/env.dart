import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String fileName = '.env';
  static String get apiKey {
    return dotenv.env['GOOGLE_API_KEY'] ?? "uhhh no key found :((";
  }

  static String get appID {
    return dotenv.env['GOOGLE_APP_ID'] ??
        "where did i pput it uhhh idk have this instead: :3";
  }

  static String get messagingSenderId {
    return dotenv.env['GOOGLE_MESSAGING_SENDER_ID'] ??
        "yknow instead of that how about 1000 beers";
  }

  static String get projectId {
    return dotenv.env['GOOGLE_PROJECT_ID'] ??
        "project id uhhh idk never heard of her";
  }
}
